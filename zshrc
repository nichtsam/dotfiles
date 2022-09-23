# Set variables
export LANG=en_US.UTF-8
export DOTFILES="$HOME/.dotfiles"

# Alias
alias exa='exa -Faals Name --git'
alias ls='exa -Faals Name --git'
alias trail='cat -n <<<${(F)path}'
source "$DOTFILES/zsh/alias/git.zsh"

# Handle PATH
typeset -U path
path=(
  "/opt/homebrew/bin"
  $path
)

eval "$(fnm env --use-on-cd)"

