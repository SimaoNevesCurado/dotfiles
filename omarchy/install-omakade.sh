#!/usr/bin/env bash
set -euo pipefail

version=1.12.0
release=1
arch=$(uname -m)
case "$arch" in
  aarch64|x86_64) ;;
  *) printf 'Unsupported Omakade architecture: %s\n' "$arch" >&2; exit 1 ;;
esac

installed=$(pacman -Q omakade 2>/dev/null | cut -d ' ' -f 2 || true)
if [[ -n "$installed" ]] && (( $(vercmp "$installed" "$version-$release") >= 0 )); then
  printf 'Omakade %s already installed.\n' "$installed"
  exit 0
fi

package="omakade-$version-$release-$arch.pkg.tar.zst"
url="https://github.com/btsouth/omakade/releases/download/v$version"
tmp=$(mktemp -d)
trap 'rm -rf -- "$tmp"' EXIT
curl -fSL "$url/$package" -o "$tmp/$package"
curl -fsSL "$url/SHA256SUMS" -o "$tmp/SHA256SUMS"
awk -v name="$package" '$2 == name || $2 == "*" name {print}' "$tmp/SHA256SUMS" > "$tmp/package.sha256"
[[ -s "$tmp/package.sha256" ]] || { printf 'Package checksum missing.\n' >&2; exit 1; }
(cd "$tmp" && sha256sum -c package.sha256)

if [[ ${DOTFILES_GUI_AUTH:-0} == 1 ]]; then
  elevate=(pkexec)
else
  elevate=(sudo)
fi
"${elevate[@]}" pacman -U --needed --noconfirm "$tmp/$package"
pacman -Q omakade
