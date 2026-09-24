#!/usr/bin/env bash
set -euo pipefail

selected=$(
  {
    find ~/Documents/projects -mindepth 1 -maxdepth 1 -type d
    zoxide query -l
  } | awk '!seen[$0]++' \
    | fzf --prompt="Project> "
)

[ -z "${selected:-}" ] && exit 0

session_name=$(basename "$selected" | tr '.' '_')

if ! tmux has-session -t "$session_name" 2>/dev/null; then
  tmux new-session -ds "$session_name" -c "$selected"
fi

if [ -n "${TMUX:-}" ]; then
  tmux switch-client -t "$session_name"
else
  tmux attach -t "$session_name"
fi
