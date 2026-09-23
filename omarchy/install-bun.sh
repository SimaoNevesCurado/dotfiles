#!/usr/bin/env bash
set -euo pipefail
export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
export PATH="$BUN_INSTALL/bin:$PATH"
if ! command -v bun >/dev/null 2>&1; then
  command -v unzip >/dev/null 2>&1 || { echo 'Install unzip before installing Bun.' >&2; exit 1; }
  installer=$(mktemp)
  trap 'rm -f "$installer"' EXIT
  curl -fsSL https://bun.com/install -o "$installer"
  bash "$installer"
fi
bun --version
