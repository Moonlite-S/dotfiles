# ==============================================================================
# Base ZSH Configuration
# ==============================================================================

# -- Homebrew Setup (Apple Silicon) --
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# -- Environment Variables --
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export EZA_CONFIG_DIR="$HOME/.config/eza"

# -- History Settings --
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# -- Aliases --
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
# alias ls="ls --color=auto"
# alias ll="ls -lah"
alias ls="eza --color=auto --icons=auto"
alias tmux="tmux -u" # Force UTF-8 for those Powerline characters
alias reload="exec zsh"
alias python="python3"
alias cd="z"
# For my Claude Code LM Studio Integration
alias claudelm="claude --settings ~/.claude/lmstudio.settings.json"

# Sketchybar & Yabai shortcuts
alias sreload="sketchybar --reload"
alias yreload="yabai --restart-service"

# NVM Initialization
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Define XDG Base Directories
export XDG_CONFIG_HOME="$HOME/.config"

# -- Basic Prompt (If you aren't using Starship or OhMyZsh) --
PROMPT='%B%F{cyan}%~%f%b ❯ '

# ==============================================================================
# Source any additional local setups
# ==============================================================================
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Initialize Starship prompt
eval "$(starship init zsh)"

# ==============================================================================
# Zsh Plugins (Autosuggestions & Syntax Highlighting)
# ==============================================================================

# 1. Autosuggestions (The grey ghost text for autocomplete)
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# 2. Syntax Highlighting (The red/green command colorizer)
# This MUST be the last thing sourced in your .zshrc
if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# EDITOR=nvim contains "vi" so zsh auto-enables vi keybindings — override it.
bindkey -e

# Reset cursor to steady block after every command so programs that leave a
# beam cursor (fzf, less, bat, delta…) don't pollute the prompt.
autoload -Uz add-zsh-hook
add-zsh-hook precmd _reset_cursor_shape
_reset_cursor_shape() { printf '\e[2 q' }

add-zsh-hook chpwd list_on_cd
list_on_cd() { ls -F }

# Function to auto-activate/deactivate venvs
auto_python_venv() {
  # If a venv exists in the current directory, activate it
  if [[ -d "venv" ]]; then
    source venv/bin/activate
  elif [[ -d ".venv" ]]; then
    source .venv/bin/activate
  # If no venv is found but one is currently active, deactivate it
  # (Optional: Only if the active venv isn't in a parent directory)
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    # Check if we are still inside the active venv's parent directory
    local parent_dir=$(dirname "$VIRTUAL_ENV")
    if [[ "$PWD" != "$parent_dir"* ]]; then
      deactivate
    fi
  fi
}

# Register the function to run on directory change (chpwd)
add-zsh-hook chpwd auto_python_venv

# Run it once on shell startup in case you start in a venv directory
auto_python_venv

# Load private local configurations if they exist
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi

export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#ffb7b2,fg+:#ff8fa3
  --color=hl:#89DCEB,hl+:#96CDFB,info:#E2C3C6,marker:#A6D189
  --color=prompt:#FF8FA3,spinner:#CAB8EE,pointer:#CAB8EE,header:#908caa
  --color=border:#908caa,label:#7A738C,query:#F4EDEA'

eval "$(zoxide init zsh)"

export PATH="$HOME/.local/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/sapple/.lmstudio/bin"
# End of LM Studio CLI section

