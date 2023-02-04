# Set variables
export LANG=en_US.UTF-8
export DOTFILES="$HOME/.dotfiles"
export HOMEBREW_BUNDLE_FILE="$DOTFILES/Brewfile"

# Alias
alias exa='exa -Faals Name --git'
alias ls='exa -Faals Name --git'
alias trail='cat -n <<<${(F)path}'
alias bbd='brew bundle dump --force --describe'
source "$DOTFILES/zsh/alias/git.zsh"

# Handle PATH
typeset -U path
path=(
  "$HOME/.cargo/bin"
  "/opt/homebrew/bin"
  $path
)

eval "$(fnm env --use-on-cd)"

# Setup Starship
eval "$(starship init zsh)"

# Plugins
source "$DOTFILES/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
