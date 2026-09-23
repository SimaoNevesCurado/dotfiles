# Bun
export BUN_INSTALL="$HOME/.bun"
case ":$PATH:" in
  *":$BUN_INSTALL/bin:"*) ;;
  *) export PATH="$BUN_INSTALL/bin:$PATH" ;;
esac

# Omarchy environment (OMARCHY_PATH + PATH), needed even for non-interactive shells
[[ -r /usr/share/omarchy/default/bash/env-bootstrap ]] && source /usr/share/omarchy/default/bash/env-bootstrap

# PHP managed by Yerd, when available.
if [[ -x "$HOME/.local/share/yerd/bin/php" ]]; then
  export PATH="$HOME/.local/share/yerd/bin:$PATH"
  [[ ! -f "$HOME/.local/share/yerd/php-cli.ini" ]] || export PHPRC="$HOME/.local/share/yerd/php-cli.ini"
fi
export PATH="${COMPOSER_HOME:-${XDG_CONFIG_HOME:-$HOME/.config}/composer}/vendor/bin:$PATH"

# If not running interactively, don't do anything else (leave this above the rc source)
[[ $- != *i* ]] && return

# All the default Omarchy aliases and functions
# (don't mess with these directly, just overwrite them here!)
source "$OMARCHY_PATH/default/bash/rc"

# Add your own exports, aliases, and functions here.
#
# Make an alias for invoking commands you use constantly
# alias p='python'
alias hx="helix"

alias w='cd ~/Work'
