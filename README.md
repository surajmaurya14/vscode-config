# vscode-config

Personal Visual Studio Code configuration — settings, keybindings, snippets, and extension list, with scripts to apply it on a fresh machine and snapshot the current state back into the repo.

Snapshot: VS Code `1.118.1` on macOS (arm64), May 2026.

## Layout

```
.
├── User/                                # mirrors VS Code's User directory
│   ├── settings.json
│   ├── keybindings.json
│   └── snippets/
│       └── sumconsole.code-snippets
├── extensions.txt                       # one extension ID per line
├── templates/
│   └── temp.cpp                         # competitive-programming starter
└── scripts/
    ├── install.sh                       # apply this config to the current machine
    └── backup.sh                        # snapshot the current machine into this repo
```

The `User/` tree mirrors VS Code's user directory, so installation is a straight copy:

| OS      | VS Code user directory                          |
| ------- | ----------------------------------------------- |
| macOS   | `~/Library/Application Support/Code/User/`      |
| Linux   | `~/.config/Code/User/`                          |
| Windows | `%APPDATA%\Code\User\`                          |

## Usage

### First-time install on a new machine

Requires the `code` CLI on `PATH`. If it's missing, open VS Code → ⌘⇧P → **Shell Command: Install 'code' command in PATH**.

```bash
git clone git@github.com:surajmaurya14/vscode-config.git
cd vscode-config
./scripts/install.sh
```

`install.sh` copies `User/*` into VS Code's user directory (after backing up any existing files to `.backup-<timestamp>/` next to them) and then installs every extension from `extensions.txt`.

### Snapshot the current machine back into this repo

```bash
./scripts/backup.sh
git diff
git commit -am "Update VS Code config snapshot"
git push
```

`backup.sh` overwrites `User/*` and `extensions.txt` with whatever's currently live, sorted. Always review with `git diff` before committing — your last edits in VS Code (and any auto-generated cruft like ephemeral file paths) will be in there.

## Highlights

- Theme: built-in **Light+** with **Material Icon Theme** (`pkief.material-icon-theme`).
- Sidebar on the right, minimap off, format-on-save on (off for Python — Ruff handles it).
- Document formatter rebound from `shift+alt+f` → `shift+cmd+/`.
- C/C++ uses Homebrew `gcc-14` on Apple Silicon (`/opt/homebrew/bin/gcc-14`); change `C_Cpp.default.compilerPath` for Intel Macs or Linux.
- Python: [Ruff](https://marketplace.visualstudio.com/items?itemName=charliermarsh.ruff) for format/lint.
- JS / TS / JSON / HTML / CSS / Markdown / YAML formatted by Prettier (or `redhat.vscode-yaml` for YAML).
- The `cph.*` settings and the `ctrl+shift+\`` / `ctrl+\`` bindings target [Competitive Programming Helper](https://marketplace.visualstudio.com/items?itemName=DivyanshuAgrawal.competitive-programming-helper).
- The `sumconsole` snippet expands into one of three scaffolds — competitive C++, basic C++, or JavaScript stdin — pick from the dropdown when the prefix triggers. `templates/temp.cpp` matches the competitive C++ flavor for quick scratch use.
