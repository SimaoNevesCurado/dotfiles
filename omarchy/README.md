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
- Minimal VS Code settings from `../vscode/settings.json`: Catppuccin Frappé, matching file icons, and 15 px Medium JetBrainsMono Nerd Font. With VS Code already installed, `packages.sh` restores extensions and removes APC. Omarchy theme synchronization uses its built-in integration, with a Frappé override for Catppuccin. See [VS Code instructions](../vscode/README.md).
- Zed as the default editor, with an Omarchy color theme generated on theme changes.
- Codex CLI as the default coding agent. Existing Codex settings and authentication are preserved.
- GitHub Desktop and CLI, plus a separate `setup-github.sh` for browser login and SSH registration.
- ARM64 PhpStorm and GeistMono Nerd Font.
- Signal Desktop from the Arch Linux ARM repository.
- [Omakade](https://github.com/btsouth/omakade) 1.12.0 from the official GitHub release, with SHA-256 verification and ARM64/x86-64 support. Install with `./install-omakade.sh` (or `DOTFILES_GUI_AUTH=1 ./install-omakade.sh` for graphical administrator authentication); `packages.sh` also runs it. Launch with `omakade` or from the application launcher. Existing settings and library data remain local. The script skips an installed version that is equal or newer; update its version when adopting a newer release.
- Yerd 2.0.4, repackaged from the official ARM64 Debian binary into a pacman-managed package with SHA-256 verification. Install independently with `./install-yerd.sh` (or `DOTFILES_GUI_AUTH=1 ./install-yerd.sh` for graphical administrator authentication). Open Yerd from the launcher to complete daemon, PHP and local domain setup. The upstream Arch package currently targets x86-64 only; `yerd/PKGBUILD` provides the ARM64 packaging. Runtime data and certificates are not stored in this repository.

Sublime Text, Claude, Herdr and Hod are not installed by these scripts. No credentials or SSH keys are stored in this directory.

Keep Arch fully updated (`sudo pacman -Syu`) before installing Yerd, as recommended by [upstream](https://yerd.app/guide/getting-started). The installer does not perform a full system upgrade automatically.

## Shortcuts

Custom bindings are defined in [`config/hypr/bindings.lua`](config/hypr/bindings.lua) and loaded after Omarchy defaults. `Super` is the Windows key, or Command on a Mac keyboard. These bindings replace any Omarchy actions on the same keys.

### Application shortcuts

For the letter shortcuts below, applications receive `Ctrl + letter`. Windows tagged as terminals receive `Ctrl + Shift + letter`. The action depends on what the active application supports; the labels describe the intended application behavior.

| Shortcut | Intended action |
| --- | --- |
| `Super + B` | Bold |
| `Super + D` | Bookmark |
| `Super + F` | Find |
| `Super + G` | Find next |
| `Super + I` | Italic |
| `Super + J` | Downloads |
| `Super + K` | Insert link |
| `Super + L` | Focus address bar |
| `Super + N` | New window |
| `Super + O` | Open |
| `Super + P` | Print |
| `Super + R` | Reload |
| `Super + S` | Save |
| `Super + T` | New tab |
| `Super + U` | Underline |
| `Super + W` | Close tab |
| `Super + Z` | Undo |

### Window, tabs and zoom

These shortcuts behave the same in applications and terminals, subject to application support. `Super + Q` closes the active window directly through Hyprland.

| Shortcut | Action | Keys sent to application |
| --- | --- | --- |
| `Super + Q` | Close active window | Hyprland close action |
| `Super + A` | Select all | `Ctrl + A` |
| `Super + Shift + Z` | Redo | `Ctrl + Shift + Z` |
| `Super + Shift + T` | Reopen closed tab | `Ctrl + Shift + T` |
| `Super + 0` | Reset zoom | `Ctrl + 0` |
| `Super + -` | Zoom out | `Ctrl + -` |
| `Super + =` | Zoom in | `Ctrl + =` |
| `Super + [` | Go back | `Alt + Left` |
| `Super + ]` | Go forward | `Alt + Right` |
| `Super + Shift + [` | Previous tab | `Ctrl + Shift + Tab` |
| `Super + Shift + ]` | Next tab | `Ctrl + Tab` |

Reset zoom uses physical key `code:19` (the `0` position). The bracket, minus and equal bindings use named key symbols, so their availability depends on the keyboard layout.

### Text navigation and selection

| Shortcut | Action | Keys sent to application |
| --- | --- | --- |
| `Super + Left / Right` | Start / end of line | `Home / End` |
| `Super + Up / Down` | Start / end of document | `Ctrl + Home / End` |
| `Super + Shift + Left / Right` | Select to start / end of line | `Shift + Home / End` |
| `Super + Shift + Up / Down` | Select to start / end of document | `Ctrl + Shift + Home / End` |
| `Alt + Left / Right` | Previous / next word | `Ctrl + Left / Right` |
| `Alt + Shift + Left / Right` | Select previous / next word | `Ctrl + Shift + Left / Right` |

### Text deletion

| Shortcut | Intended action | Application receives | Terminal receives |
| --- | --- | --- | --- |
| `Super + Backspace` | Delete to start of line | `Shift + Home`, then `Backspace` | `Ctrl + U` |
| `Alt + Backspace` | Delete previous word | `Ctrl + Backspace` | `Ctrl + W` |
| `Alt + Delete` | Delete next word | `Ctrl + Delete` | `Alt + D` |

Terminal behavior depends on the shell or program running inside it. For example, `Super + A` sends `Ctrl + A`, which commonly moves to the start of the command line instead of selecting all.

### Inherited Omarchy shortcuts

`Super + C / V / X` use Omarchy's default clipboard bindings; this file does not redefine them.

The normal Omarchy editor shortcut, Super+Shift+N, opens Zed. The agent shortcut, Super+Ctrl+Shift+A, uses Codex. The Zed theme is defined in `config/omarchy/themed/zed.json.tpl`, using the [Zed theme schema](https://zed.dev/schema/themes/v0.2.0.json). Codex installation and login are documented in the [official documentation](https://developers.openai.com/codex/cli).

## GitHub

Run `./setup-github.sh` and authorize your own account in the browser. The script identifies the account through GitHub's API, preserves your existing Git commit name and email, creates an Ed25519 key without a passphrase if none exists, and uploads only the public key. Host keys come from GitHub's authenticated HTTPS API. An existing private key is reused. GitHub Desktop may require its own browser login.

## Keep it current

After changing a setting, copy it back into the matching file here. Review monitor and VM input settings before using this on another machine. Keep a separate backup or publish your own repository; this folder alone does not protect against loss of the VM.
