#!/usr/bin/env bash
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ ${DOTFILES_GUI_AUTH:-0} == 1 ]]; then
  elevate=(pkexec)
  aur=(yay --sudo pkexec)
else
  elevate=(sudo)
  aur=(yay)
fi

if ! pacman -Q firefox >/dev/null 2>&1; then
  "${elevate[@]}" pacman -S --needed --noconfirm firefox
fi
"${aur[@]}" -S --needed --noconfirm python-pywalfox github-desktop-bin

if ! pacman -Q signal-desktop >/dev/null 2>&1; then
  "${elevate[@]}" pacman -S --needed --noconfirm signal-desktop
fi

for app in gh codex; do
  if ! command -v "$app" >/dev/null 2>&1; then
    omarchy mise install "$app"
  fi
done
if ! command -v zed >/dev/null 2>&1; then
  installer=$(mktemp)
  curl -fsSL https://zed.dev/install.sh -o "$installer"
  sh "$installer"
  rm -f "$installer"
fi

"${elevate[@]}" "$repo/system/install-firefox-policies.py" "$repo/system/firefox-policies.json"
env -u BROWSER xdg-settings set default-web-browser firefox.desktop
pywalfox install

PHPSTORM_HOME="$HOME/.local/phpstorm"

if [ -x "$PHPSTORM_HOME/bin/phpstorm" ]; then
  echo "phpstorm already installed"
else
  echo "installing phpstorm..."
  release="$(curl -fsSL 'https://data.services.jetbrains.com/products/releases?code=PS&latest=true&type=release')"
  url="$(printf '%s' "$release" | jq -r '.PS[0].downloads.linuxARM64.link')"
  checksum_url="$(printf '%s' "$release" | jq -r '.PS[0].downloads.linuxARM64.checksumLink')"

  tmp="$(mktemp -d)"
  curl -fSL -o "$tmp/phpstorm.tar.gz" "$url"

  expected="$(curl -fsSL "$checksum_url" | cut -d' ' -f1)"
  actual="$(sha256sum "$tmp/phpstorm.tar.gz" | cut -d' ' -f1)"

  if [ "$expected" != "$actual" ]; then
    echo "the download of phpstorm does not match its checksum at $checksum_url"
    echo "delete $tmp and run ./packages.sh again"
    exit 1
  fi

  mkdir -p "$PHPSTORM_HOME"
  tar -xzf "$tmp/phpstorm.tar.gz" -C "$PHPSTORM_HOME" --strip-components=1
  rm -rf "$tmp"

  mkdir -p "$HOME/.local/bin"
  ln -sfn "$PHPSTORM_HOME/bin/phpstorm" "$HOME/.local/bin/phpstorm"

  mkdir -p "$HOME/.local/share/applications"
  cat > "$HOME/.local/share/applications/phpstorm.desktop" <<EOF
[Desktop Entry]
Type=Application
Name=PhpStorm
Comment=Lightweight and Smart PHP IDE
Icon=$PHPSTORM_HOME/bin/phpstorm.svg
Exec=$PHPSTORM_HOME/bin/phpstorm %f
Categories=Development;IDE;
Terminal=false
StartupWMClass=jetbrains-phpstorm
StartupNotify=true
EOF
fi

FONT="GeistMono Nerd Font"

if fc-list : family | grep -Fq "$FONT"; then
  echo "$FONT already installed"
else
  echo "installing $FONT..."
  tmp="$(mktemp -d)"
  curl -fsSL -o "$tmp/GeistMono.tar.xz" \
    https://github.com/ryanoasis/nerd-fonts/releases/latest/download/GeistMono.tar.xz
  mkdir -p "$HOME/.local/share/fonts/GeistMono"
  tar -xf "$tmp/GeistMono.tar.xz" -C "$HOME/.local/share/fonts/GeistMono"
  rm -rf "$tmp"
  fc-cache -f "$HOME/.local/share/fonts"
fi

if command -v omarchy >/dev/null 2>&1 && [ "$(omarchy font current 2>/dev/null)" != "$FONT" ]; then
  echo "setting $FONT as the system monospace font..."
  omarchy font set "$FONT"
fi


omarchy theme set "$(omarchy theme current)"
printf '\nPackages and appearance configured. Run ./setup-github.sh to connect GitHub.\n'
