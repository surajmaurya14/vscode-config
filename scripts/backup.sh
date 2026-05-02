#!/usr/bin/env bash
# Snapshot the current VS Code user config and installed extension list back
# into this repo. Review with `git diff` before committing.

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

case "$(uname -s)" in
    Darwin)  VSCODE_USER="$HOME/Library/Application Support/Code/User" ;;
    Linux)   VSCODE_USER="$HOME/.config/Code/User" ;;
    MINGW*|MSYS*|CYGWIN*) VSCODE_USER="$APPDATA/Code/User" ;;
    *)       echo "Unsupported OS: $(uname -s)" >&2; exit 1 ;;
esac

if command -v code >/dev/null 2>&1; then
    CODE_BIN="code"
elif [[ -x "/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code" ]]; then
    CODE_BIN="/Applications/Visual Studio Code.app/Contents/Resources/app/bin/code"
else
    echo "ERROR: 'code' CLI not found." >&2; exit 1
fi

mkdir -p "$REPO_DIR/User/snippets"
cp "$VSCODE_USER/settings.json"                      "$REPO_DIR/User/settings.json"
cp "$VSCODE_USER/keybindings.json"                   "$REPO_DIR/User/keybindings.json"
cp "$VSCODE_USER/snippets/sumconsole.code-snippets"  "$REPO_DIR/User/snippets/sumconsole.code-snippets"
"$CODE_BIN" --list-extensions | sort > "$REPO_DIR/extensions.txt"

echo "Snapshot updated. Review with: git -C \"$REPO_DIR\" diff"
