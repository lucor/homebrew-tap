#!/usr/bin/env bash
set -euo pipefail

script_path="$(cd "$(dirname "$0")/../scripts" && pwd)/autobump.sh"
fixture_dir="$(mktemp -d)"
trap 'rm -rf "$fixture_dir"' EXIT
mkdir -p "$fixture_dir/bin" "$fixture_dir/Casks"
touch "$fixture_dir/Casks/alpha.rb" "$fixture_dir/Casks/beta.rb"
cat > "$fixture_dir/bin/brew" <<'STUB'
#!/usr/bin/env bash
printf '%s\n' "$*" >> "$BREW_CALLS"
[[ "${*: -1}" != "${FAIL_PACKAGE:-}" ]]
STUB
chmod +x "$fixture_dir/bin/brew"
export PATH="$fixture_dir/bin:$PATH"
export BREW_CALLS="$fixture_dir/calls"
cd "$fixture_dir"

REQUESTED_PACKAGE='' bash "$script_path"
printf '%s\n' 'bump --casks --open-pr --no-fork lucor/tap/alpha' \
  'bump --casks --open-pr --no-fork lucor/tap/beta' > expected
diff -u expected "$BREW_CALLS"

: > "$BREW_CALLS"
REQUESTED_PACKAGE=beta bash "$script_path"
printf '%s\n' 'bump --casks --open-pr --no-fork lucor/tap/beta' > expected
diff -u expected "$BREW_CALLS"

: > "$BREW_CALLS"
if FAIL_PACKAGE=lucor/tap/alpha REQUESTED_PACKAGE='' bash "$script_path"; then
  echo 'Expected a failed package to fail the run' >&2
  exit 1
fi
test "$(wc -l < "$BREW_CALLS" | tr -d ' ')" = 2

for invalid in missing '../alpha' 'alpha; touch injected'; do
  : > "$BREW_CALLS"
  if REQUESTED_PACKAGE="$invalid" bash "$script_path"; then
    echo "Expected invalid selection to fail: $invalid" >&2
    exit 1
  fi
  test ! -s "$BREW_CALLS"
done
test ! -e injected

mkdir empty
cd empty
if REQUESTED_PACKAGE='' bash "$script_path"; then
  echo 'Expected an empty tap to fail' >&2
  exit 1
fi
echo 'Autobump tests passed'
