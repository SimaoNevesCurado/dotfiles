# Dotfiles

Personal configuration for macOS and Omarchy.

- [`aerospace.toml`](aerospace.toml): AeroSpace window manager configuration.
- [`helix/`](helix/): Helix editor configuration.
- [`vscode/`](vscode/): VS Code settings.
- [`omarchy/`](omarchy/): Omarchy ARM64 setup with Zed, Codex, Firefox, GitHub tools, PhpStorm, and Mac-style shortcuts.

## Omarchy

On an existing compatible Omarchy installation:

```bash
git clone git@github.com:SimaoNevesCurado/dotfiles.git
cd dotfiles/omarchy
./install.sh --dry-run
./setup.sh
```

Read the [Omarchy instructions](omarchy/README.md) before restoring on another machine. Changed configuration files are backed up. GitHub authentication runs through your browser; credentials and SSH keys are not included in the repository.
