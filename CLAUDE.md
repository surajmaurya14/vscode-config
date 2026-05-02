# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repo is

A personal Visual Studio Code configuration snapshot — `settings.json`, `keybindings.json`, snippets, and an extension list — plus shell scripts to apply it on a fresh machine and snapshot the current machine back into the repo. There is no application code, build, lint, or test suite.

## Common commands

- `./scripts/install.sh` — copy `User/*` into VS Code's user directory (backing up any existing files to `.backup-<timestamp>/` first) and install every extension from `extensions.txt` via `code --install-extension`.
- `./scripts/backup.sh` — overwrite `User/*` and `extensions.txt` with whatever is currently live on this machine. Always `git diff` before committing.

Both scripts auto-detect macOS / Linux / Windows-bash, locate `code` on `PATH` (falling back to `/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code` on macOS), and abort if it isn't available.

## Architecture & conventions

- **`User/` mirrors VS Code's user directory exactly** (`~/Library/Application Support/Code/User/` on macOS). This is load-bearing: `install.sh` is a direct `cp` from `User/<file>` to the corresponding live path. The `cp` lines in **both** `scripts/install.sh` and `scripts/backup.sh` enumerate files explicitly — adding a new file under `User/` requires editing both scripts.
- **`extensions.txt`** is a plain newline-separated list of extension IDs with no header. `install.sh` skips blank lines and `#`-prefixed comments.
- **JSONC, not strict JSON.** `User/settings.json`, `User/keybindings.json`, and `User/snippets/*.code-snippets` contain `//` comments and trailing commas. `JSON.parse` and most strict parsers will fail on them; use a JSONC-aware parser, or strip comments and trailing commas first (taking care not to eat `//` inside string literals like `http://...`).
- **`templates/temp.cpp` mirrors the body of the `Competitive Programming` flavor of the `sumconsole` snippet.** If one changes, update the other.

## Machine-specific values in `User/settings.json`

These are real paths/IDs for the maintainer's macOS Apple-Silicon setup, not portable defaults. Don't generalize them unless asked:

- `C_Cpp.default.compilerPath` and `cph.language.{c,cpp}.Command` → Homebrew `gcc-14` at `/opt/homebrew/bin/gcc-14`.
- `C_Cpp.default.intelliSenseMode` → `macos-gcc-arm64`.
- `dart.flutterSdkPath` → `/Users/suraj/Applications/Flutter/flutter`.

## Snapshot flow

The repo is a snapshot, not a live source the editor reads from. Intended workflow:

1. Edit settings inside VS Code (or edit `User/*` directly, then run `install.sh` to push to the live config).
2. `./scripts/backup.sh` to re-export the live state into the repo.
3. `git diff` → commit → push.

Editing `User/*` directly without first pushing through to the live config is fine, but the next `backup.sh` run will overwrite those edits with whatever VS Code currently has on disk.
