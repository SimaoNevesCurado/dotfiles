#!/usr/bin/env bash
set -euo pipefail
if ! gh auth status --hostname github.com >/dev/null 2>&1; then
  gh auth login --hostname github.com --git-protocol ssh --web --skip-ssh-key --scopes admin:public_key
fi
account=$(gh api user --jq .login)
printf 'GitHub account: %s\n' "$account"
key="$HOME/.ssh/id_ed25519"
mkdir -p "$HOME/.ssh"
chmod 700 "$HOME/.ssh"
if [[ ! -f "$key" ]]; then
  ssh-keygen -q -t ed25519 -N '' -C "$account@$(uname -n)" -f "$key"
fi
if [[ ! -f "$key.pub" ]]; then
  ssh-keygen -y -f "$key" > "$key.pub"
fi
chmod 600 "$key"
keys=$(gh api user/keys --paginate --jq '.[].key') || {
  gh auth refresh --hostname github.com --scopes admin:public_key
  keys=$(gh api user/keys --paginate --jq '.[].key')
}
if ! grep -Fq "$(cut -d' ' -f2 "$key.pub")" <<< "$keys"; then
  gh ssh-key add "$key.pub" --title "Omarchy - $(uname -n)"
fi
gh config set git_protocol ssh --host github.com
if [[ -z $(git config --global --get user.name || true) ]]; then
  git config --global user.name "$account"
fi
if [[ -z $(git config --global --get user.email || true) ]]; then
  id=$(gh api user --jq .id)
  git config --global user.email "$id+$account@users.noreply.github.com"
fi
host_keys=$(gh api meta --jq '.ssh_keys[]')
while IFS= read -r host_key; do
  entry="github.com $host_key"
  if ! grep -Fqx "$entry" "$HOME/.ssh/known_hosts" 2>/dev/null; then
    printf '%s\n' "$entry" >> "$HOME/.ssh/known_hosts"
  fi
done <<< "$host_keys"
chmod 600 "$HOME/.ssh/known_hosts"
printf 'GitHub SSH configured for %s.\n' "$account"
