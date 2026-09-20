# ==============================================================================
# Base ZSH Configuration
# ==============================================================================

 # Homebrew Setup (Apple Silicon) --
if [[ -f /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

 # Environment Variables --
export EDITOR="nvim"
export VISUAL="nvim"
export TERM="xterm-256color"
export EZA_CONFIG_DIR="$HOME/.config/eza"
export XDG_CONFIG_HOME="$HOME/.config"
export PATH="$HOME/.local/bin:$PATH"
export PATH="$PATH:/Users/sapple/.lmstudio/bin"

 # History Settings --
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks


 # Aliases --
alias vim="nvim"
alias vi="nvim"
alias v="nvim"
alias ls="eza --color=auto --icons=auto "
alias ll="eza --all --header --long --icons=auto "
alias lt="eza --tree --icons=auto "
alias tmux="tmux -u"
alias reload="exec zsh"
alias python="python3"
alias cd="z"
alias claudelm="claude --settings ~/.claude/lmstudio.settings.json"
alias sreload="sketchybar --reload"
alias yreload="yabai --restart-service"

 # NVM Initialization --
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

 # FZF Configuration --
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_DEFAULT_OPTS=$FZF_DEFAULT_OPTS'
  --color=fg:#ffb7b2,fg+:#ff8fa3
  --color=hl:#89DCEB,hl+:#96CDFB,info:#E2C3C6,marker:#A6D189
  --color=prompt:#FF8FA3,spinner:#CAB8EE,pointer:#CAB8EE,header:#908caa
  --color=border:#908caa,label:#7A738C,query:#F4EDEA'

 # Zsh Plugins (Autosuggestions & Syntax Highlighting) --
if [ -f /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
  source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

if [ -f /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
  source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
fi

# Prevent vi mode from being enabled by EDITOR=nvim
bindkey -e

# Reset cursor to steady block after every command
autoload -Uz add-zsh-hook
add-zsh-hook precmd _reset_cursor_shape
_reset_cursor_shape() { printf '\e[2 q' }

# # CMP Opts
zmodload zsh/complist
autoload -Uz compinit && compinit
zstyle ':completion:*' menu select
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' list-colors 'ma=38;5;111'
# zstyle ':completion:*:*:*:*:descriptions' format 'Directory'

# Auto-activate Python venvs based on directory
auto_python_venv() {
  if [[ -d "venv" ]]; then
    source venv/bin/activate
  elif [[ -d ".venv" ]]; then
    source .venv/bin/activate
  elif [[ -n "$VIRTUAL_ENV" ]]; then
    local parent_dir=$(dirname "$VIRTUAL_ENV")
    if [[ "$PWD" != "$parent_dir"* ]]; then
      deactivate
    fi
  fi
}
add-zsh-hook chpwd auto_python_venv
auto_python_venv

 # Starship
eval "$(starship init zsh)"

 # Zoxide
eval "$(zoxide init zsh)"

 # Local Config --
if [[ -f ~/.zshrc.local ]]; then
    source ~/.zshrc.local
fi
