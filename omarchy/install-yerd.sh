#!/usr/bin/env bash
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if [[ ${DOTFILES_GUI_AUTH:-0} == 1 ]]; then
  elevate=(pkexec)
else
  elevate=(sudo)
fi
"${elevate[@]}" omarchy pkg add libxcrypt-compat
if pacman -Q yerd-bin >/dev/null 2>&1 || pacman -Q yerd >/dev/null 2>&1; then
  printf 'Yerd already installed.\n'
  exit 0
fi
if [[ $(uname -m) != aarch64 ]]; then
  printf 'This installer targets Arch Linux ARM (aarch64).\n' >&2
  exit 1
fi
build_dir=$(mktemp -d)
trap 'rm -rf -- "$build_dir"' EXIT
cp "$repo/yerd/PKGBUILD" "$build_dir/PKGBUILD"
cd "$build_dir"
"${elevate[@]}" omarchy pkg add base-devel gtk3 webkit2gtk-4.1 libayatana-appindicator libcap
makepkg --noconfirm
"${elevate[@]}" pacman -U --needed --noconfirm "$build_dir"/yerd-bin-*.pkg.tar.*
printf 'Yerd installed. Open Yerd from the launcher to complete initial setup.\n'
