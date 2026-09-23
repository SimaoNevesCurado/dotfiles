# Minimal VS Code

Catppuccin Frappé with matching file icons and Fluent UI icons. JetBrainsMono Nerd Font at 15 px, Medium (500), in the editor and terminal. Single visible tab, no minimap, breadcrumbs or activity bar. APC is no longer used.

On Omarchy, `../omarchy/install.sh` restores `settings.json` with a backup. Install VS Code first, then run `./install-extensions.sh` to restore the saved extensions and remove APC. `../omarchy/packages.sh` also installs the extensions when VS Code is available. JetBrainsMono Nerd Font must be installed.

Omarchy automatically changes the VS Code theme when the system theme changes. The Catppuccin overlay in `../omarchy/config/omarchy/themes/catppuccin/vscode.json` selects Frappé. Keep `skip-vscode-theme-changes` disabled (`omarchy toggle skip-vscode-theme-changes off`). Restoring settings initially selects Frappé; the next Omarchy theme change selects the system's theme. File icons remain Catppuccin Frappé.
