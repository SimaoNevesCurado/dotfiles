#!/usr/bin/env bash
# Restore saved user configuration onto an existing Omarchy installation.
set -euo pipefail

dotfiles_dir="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
config_dir="${XDG_CONFIG_HOME:-$HOME/.config}"
state_dir="${XDG_STATE_HOME:-$HOME/.local/state}"
dry_run=false

case "${1:-}" in
  --dry-run) dry_run=true ;;
  --help|-h)
    printf 'Usage: %s [--dry-run]\nRestores configuration, backing up replaced files first.\n' "$0"
    exit 0 ;;
  '') ;;
  *) printf 'Unknown option: %s\n' "$1" >&2; exit 1 ;;
esac
if (( $# > 1 )); then
  printf 'Expected at most one option.\n' >&2
  exit 1
fi

backup_dir=''
while IFS= read -r -d '' source_file; do
  relative_path="${source_file#"$dotfiles_dir/config/"}"
  destination="$config_dir/$relative_path"
  if [[ "$source_file" == "$dotfiles_dir/home/"* ]]; then
    relative_path="${source_file#"$dotfiles_dir/home/"}"
    destination="$HOME/$relative_path"
  fi
  if [[ "$source_file" == "$dotfiles_dir/../vscode/settings.json" ]]; then
    relative_path="Code/User/settings.json"
    destination="$config_dir/$relative_path"
  fi
  if [[ -f "$destination" ]] && cmp -s -- "$source_file" "$destination"; then
    printf 'Unchanged: %s\n' "$relative_path"
    continue
  fi
  printf 'Install: %s\n' "$destination"
  if [[ -d "$destination" ]]; then
    printf 'Refusing to replace a directory: %s\n' "$destination" >&2
    exit 1
  fi
  if "$dry_run"; then
    continue
  fi
  if [[ -e "$destination" || -L "$destination" ]]; then
    if [[ -z "$backup_dir" ]]; then
      mkdir -p -- "$state_dir/omarchy-dotfiles/backups"
      backup_dir="$(mktemp -d "$state_dir/omarchy-dotfiles/backups/$(date +%Y%m%d-%H%M%S).XXXXXX")"
      printf 'Backup: %s\n' "$backup_dir"
    fi
    mkdir -p -- "$backup_dir/$(dirname -- "$relative_path")"
    cp -a -- "$destination" "$backup_dir/$relative_path"
  fi
  mkdir -p -- "$(dirname -- "$destination")"
  # Replace a destination symlink instead of writing through it.
  cp --remove-destination -- "$source_file" "$destination"
done < <(find "$dotfiles_dir/config" "$dotfiles_dir/home" "$dotfiles_dir/../vscode/settings.json" -type f -print0)

if "$dry_run"; then
  printf 'Preview complete. No files changed.\n'
else
  printf 'Installed. Backups (if needed): %s\n' "${backup_dir:-none}"
  printf 'In your Omarchy session, run: hyprctl reload && hyprctl configerrors\n'
fi
