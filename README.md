# Lucor Homebrew Tap

Homebrew Casks for Lucor applications and command line tools.

## Install

Add the tap once, then install the package you need:

```sh
brew tap lucor/tap
brew install --cask lucor/tap/paw
brew install --cask lucor/tap/fynetune
brew install --cask lucor/tap/lancert
```

Fully qualified installation commands also add the tap automatically if needed.

Paw and FyneTune support macOS on Intel and Apple Silicon and install from DMG
files. Lancert CLI supports macOS and Linux on AMD64 and ARM64 and installs
the prebuilt binary. On Linux, use the same `brew install --cask lucor/tap/lancert`
command with a current Homebrew installation that supports Linux casks.

Paw and FyneTune are not notarized. Follow the macOS first-launch instructions
in the [Paw](https://github.com/lucor/paw#macos) and
[FyneTune](https://github.com/lucor/fynetune#macos) documentation if Gatekeeper
blocks launching them.

## Add a package

Add one Ruby file to `Casks/` for each package. Use an `app` artifact for a
desktop application distributed as a DMG, or `binary` for a command line tool.
The cask should declare the GitHub upstream in `livecheck`, use stable release
URLs, and provide a real SHA256 for each supported operating system and
architecture. Keep the package token and filename aligned.

For a macOS desktop app, declare `depends_on :macos`. For a CLI supporting both
systems, use `os` and `arch` substitutions in the URL and platform-specific
`sha256` values as in `Casks/lancert.rb`. Keep macOS-specific installation steps
inside `on_macos`. Avoid nesting checksum stanzas inside both OS and architecture
blocks: the native bump command skips those nested checksums. CI uses Homebrew's
supported platform metadata to skip incompatible casks on each runner.

For example, `Casks/paw.rb` describes Paw's DMGs and `Casks/lancert.rb`
describes the Lancert CLI archives. The release name may differ between
projects; each cask owns that URL detail, so adding a package does not require
editing the workflows.

Recommended release conventions:

- Publish stable GitHub Releases with a `v`-prefixed semantic version tag.
- Keep DMG or archive names versioned and include `darwin_amd64` or
  `darwin_arm64` in separate macOS artifacts.
- Use `linux_amd64` and `linux_arm64` for separate Linux CLI archives.
- Publish SHA256 digests with each release or include them in a checksums file.
- Do not mark prereleases or drafts as the latest stable release.

## Automatic updates

The autobump workflow checks every six hours and can also be started from the
Actions page after publishing a release. Leave the package input empty to
process every cask, or enter a
single cask token such as `paw`. Each cask is processed separately, so an
upstream error does not prevent checks for the remaining packages. Homebrew
`livecheck` finds the latest stable version, and `brew bump` updates the
version and architecture-specific checksums and opens a pull request. The
workflow never commits package updates directly to `main`.

The workflow discovers package names from `Casks/*.rb`; it does not keep a
second repository list. To add a new package, add and validate its cask file.

## GitHub Actions setup

The autobump workflow uses the built-in `GITHUB_TOKEN`. No custom token, GitHub
App, or repository secret is required in the tap or upstream repositories.
Enable **Allow GitHub Actions to create and approve pull requests** under
**Settings > Actions > General > Workflow permissions** in this repository.
The autobump job requests `contents: write` to push its update branches and
`pull-requests: write` to open PRs. Validation only needs `contents: read`.

Validation runs when files under `Casks/` or `Formula/` change in PRs targeting
`main` and on pushes to `main`, including direct commits and merges. It checks
the declared cask versions, audits them, and installs them on supported
platforms; update discovery belongs to autobump. This tap currently contains
only casks; formula validation must be added when introducing a formula.
A newer run on the same PR or branch cancels an older run. Review passing
checks before merging. Changes to other files can be checked with a manual run.

If GitHub does not start validation for a PR created with `GITHUB_TOKEN`,
manually start the validation workflow and select the update branch before
merging.

Autobump runs from `main`. Auto-merge is not configured; review and merge each
update PR normally.

## Manual checks and troubleshooting

Run the same package checks locally with Homebrew installed:

```sh
brew tap lucor/tap
brew livecheck --cask --tap=lucor/tap
brew audit --cask --strict --tap=lucor/tap
brew style Casks/*.rb
mise run test
```

The named tap checks use the installed tap. CI registers its checkout directly
as the tap, so it validates the selected revision and installs compatible casks
on macOS and Linux, on both AMD64 and ARM64. Run `mise install` and
`mise run check` for local workflow, shell syntax, cask style, and autobump tests.

To run one autobump manually, use the Actions page's **Run workflow** button
and enter its cask token. If a package fails, inspect that package's log for
its livecheck result, release URL, and download checksum. Confirm the upstream
release is published (not a draft or prerelease), contains all declared platform
artifacts, and uses the filenames declared in the cask. A failed package is
reported while the workflow continues with the others.
