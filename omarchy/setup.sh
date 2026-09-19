#!/usr/bin/env bash
set -euo pipefail
repo="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
"$repo/install.sh"
"$repo/packages.sh"
"$repo/setup-github.sh"
