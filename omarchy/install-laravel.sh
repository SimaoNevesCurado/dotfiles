#!/usr/bin/env bash
set -euo pipefail
if [[ ${DOTFILES_GUI_AUTH:-0} == 1 ]]; then
  elevate=(pkexec)
else
  elevate=(sudo)
fi
"${elevate[@]}" omarchy pkg add libxcrypt-compat composer
if [[ -x "$HOME/.local/share/yerd/bin/php" ]]; then
  export PATH="$HOME/.local/share/yerd/bin:$PATH"
  [[ ! -f "$HOME/.local/share/yerd/php-cli.ini" ]] || export PHPRC="$HOME/.local/share/yerd/php-cli.ini"
fi
if ! php --version; then
  printf 'Complete PHP setup in Yerd, then rerun ./install-laravel.sh.\n' >&2
  exit 1
fi
composer global require laravel/installer --no-interaction --prefer-dist
composer_bin=$(composer global config bin-dir --absolute --quiet)
"$composer_bin/laravel" --version
printf 'Laravel installed. Open a new terminal to use laravel new.\n'
