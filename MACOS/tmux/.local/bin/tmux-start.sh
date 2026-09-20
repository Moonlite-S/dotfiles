#!/usr/bin/env bash
export PATH="/opt/homebrew/bin:$PATH"

[[ -n "$TMUX" ]] && exec zsh -l
command -v tmux >/dev/null 2>&1 || exec zsh -l

RESURRECT_DIR="$HOME/.local/share/tmux/resurrect"

if tmux list-sessions 2>/dev/null | grep -q .; then
  tmux attach-session
elif [[ -d "$RESURRECT_DIR" ]] && [[ -n "$(ls "$RESURRECT_DIR"/*.txt 2>/dev/null)" ]]; then
  tmux new-session -d -s __restore 2>/dev/null
  SOCKET=$(tmux display-message -p -t __restore '#{socket_path}' 2>/dev/null)
  TMUX="$SOCKET,0,0" bash "$HOME/.tmux/plugins/tmux-resurrect/scripts/restore.sh" 2>/dev/null
  tmux kill-session -t __restore 2>/dev/null || true
  tmux attach-session 2>/dev/null || tmux new-session
else
  tmux new-session
fi

exec zsh -l
