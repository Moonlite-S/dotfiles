 # History Settings --
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt share_history
setopt hist_ignore_all_dups
setopt hist_reduce_blanks

# Aliases
alias vim="nvim"
alias vi="nvim"
alias n="nvim"
alias ls="eza --color=auto --icons=auto "
alias ll="eza --all --header --long --icons=auto "
alias lt="eza --tree --icons=auto "
alias cd="z"

eval "$(zoxide init zsh)"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/home/shawnlings/.lmstudio/bin"
# End of LM Studio CLI section

