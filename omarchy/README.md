# Omarchy dotfiles — Simão

Personal setup for this Omarchy ARM64 VM, adapted from Nuno Maduro's `omarchy-dotfiles` at commit `9eb2dba`.

## Restore

```bash
./install.sh --dry-run
./setup.sh
```

Run as your normal user in an existing Lua-based Omarchy installation. `setup.sh` restores configuration, installs applications, then connects your GitHub account through your browser. Installation requires network access and administrator authentication. Existing Codex authentication is reused; on a fresh machine, run `codex login`.

To restore only configuration, run `./install.sh`. Changed files are backed up under `~/.local/state/omarchy-dotfiles/backups/`. Files are copied, not linked. `config/` mirrors `~/.config/`; `home/` mirrors `~/`.

## Included

- Nuno's Mac-style Hyprland shortcuts, Starship prompt and `w` alias for `~/Work`.
- Portuguese keyboard layout, VM scroll adjustment, and this machine's monitor and desktop settings.
- Firefox as the default browser, Pywalfox extension and native messaging, and Firefox policy customizations.
- Zed as the default editor, with an Omarchy color theme generated on theme changes.
- Codex CLI as the default coding agent. Existing Codex settings and authentication are preserved.
- GitHub Desktop and CLI, plus a separate `setup-github.sh` for browser login and SSH registration.
- ARM64 PhpStorm and GeistMono Nerd Font.
- Signal Desktop from the Arch Linux ARM repository.

Sublime Text, Claude, Herdr and Hod are not installed by these scripts. No credentials or SSH keys are stored in this directory.

## Shortcuts

The bindings from Nuno are in `config/hypr/bindings.lua`. These replace several Omarchy window-management shortcuts: Super+F becomes Find, Super+T becomes New tab, Super+W becomes Close tab, Super+L becomes Address bar, Super+S becomes Save, and Super+arrows navigate text. Super+Q closes the window. Super+C/V/X remain provided by Omarchy's default clipboard bindings.

The normal Omarchy editor shortcut, Super+Shift+N, opens Zed. The agent shortcut, Super+Ctrl+Shift+A, uses Codex. The Zed theme is defined in `config/omarchy/themed/zed.json.tpl`, using the [Zed theme schema](https://zed.dev/schema/themes/v0.2.0.json). Codex installation and login are documented in the [official documentation](https://developers.openai.com/codex/cli).

## GitHub

Run `./setup-github.sh` and authorize your own account in the browser. The script identifies the account through GitHub's API, preserves your existing Git commit name and email, creates an Ed25519 key without a passphrase if none exists, and uploads only the public key. Host keys come from GitHub's authenticated HTTPS API. An existing private key is reused. GitHub Desktop may require its own browser login.

## Keep it current

After changing a setting, copy it back into the matching file here. Review monitor and VM input settings before using this on another machine. Keep a separate backup or publish your own repository; this folder alone does not protect against loss of the VM.
