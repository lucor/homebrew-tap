#!/usr/bin/env bash
set -euo pipefail
shopt -s nullglob

packages=()
requested_package="${REQUESTED_PACKAGE:-}"
if [[ -n "$requested_package" ]]; then
  if [[ ! "$requested_package" =~ ^[a-z0-9][a-z0-9._+@-]*$ || ! -f "Casks/${requested_package}.rb" ]]; then
    echo "Unknown or invalid cask token: $requested_package" >&2
    exit 2
  fi
  packages+=("$requested_package")
else
  for cask_file in Casks/*.rb; do
    package="${cask_file##*/}"
    packages+=("${package%.rb}")
  done
fi

if (( ${#packages[@]} == 0 )); then
  echo "No casks found in Casks/" >&2
  exit 2
fi

failures=0
for package in "${packages[@]}"; do
  echo "Checking $package"
  # --tap ignores named packages. --full-name also preserves the tap when
  # brew bump invokes bump-cask-pr, avoiding collisions with official casks.
  if brew bump --casks --full-name --open-pr --no-fork "lucor/tap/$package"; then
    echo "Finished $package"
  else
    echo "Failed to update $package; continuing" >&2
    failures=$((failures + 1))
  fi
done

if (( failures > 0 )); then
  echo "$failures package(s) failed" >&2
  exit 1
fi
