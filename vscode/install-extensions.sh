#!/usr/bin/env bash
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
if ! command -v code >/dev/null 2>&1; then
  printf 'VS Code is not installed. Install it, then run %s again.\n' "$0" >&2
  exit 1
fi
installed=$(code --list-extensions)
if grep -Fxiq 'drcika.apc-extension' <<< "$installed"; then
  code --uninstall-extension drcika.apc-extension
fi
while IFS= read -r extension; do
  [[ -z "$extension" || "$extension" == \#* ]] && continue
  if ! grep -Fxiq "$extension" <<< "$installed"; then
    code --install-extension "$extension"
  fi
done < "$repo/extensions.txt"
