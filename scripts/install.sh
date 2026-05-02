#!/usr/bin/env bash
# Apply this VS Code config to the current machine: copy User/* into VS Code's
# user directory and install every extension from extensions.txt.

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
    echo "ERROR: 'code' CLI not found." >&2
    echo "Open VS Code, run 'Shell Command: Install code command in PATH', then re-run." >&2
    exit 1
fi

mkdir -p "$VSCODE_USER/snippets"

# Backup any existing files before overwriting.
BACKUP_DIR="$VSCODE_USER/.backup-$(date +%Y%m%d-%H%M%S)"
needs_backup=0
for f in settings.json keybindings.json snippets/sumconsole.code-snippets; do
    [[ -f "$VSCODE_USER/$f" ]] && needs_backup=1
done
if (( needs_backup )); then
    mkdir -p "$BACKUP_DIR/snippets"
    for f in settings.json keybindings.json snippets/sumconsole.code-snippets; do
        [[ -f "$VSCODE_USER/$f" ]] && cp "$VSCODE_USER/$f" "$BACKUP_DIR/$f"
    done
    echo "Backed up existing config to: $BACKUP_DIR"
fi

cp "$REPO_DIR/User/settings.json"                      "$VSCODE_USER/settings.json"
cp "$REPO_DIR/User/keybindings.json"                   "$VSCODE_USER/keybindings.json"
cp "$REPO_DIR/User/snippets/sumconsole.code-snippets"  "$VSCODE_USER/snippets/sumconsole.code-snippets"
echo "Installed config to: $VSCODE_USER"

echo "Installing extensions..."
while IFS= read -r ext; do
    [[ -z "$ext" || "$ext" =~ ^[[:space:]]*# ]] && continue
    "$CODE_BIN" --install-extension "$ext" --force
done < "$REPO_DIR/extensions.txt"

echo "Done."
