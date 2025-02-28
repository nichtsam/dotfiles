# Set variables
export LANG=en_US.UTF-8
export DOTFILES="$HOME/.dotfiles"
export HOMEBREW_BUNDLE_FILE="$DOTFILES/Brewfile"

# Alias
alias ls='lsd -lg'
alias tree='lsd --tree'
alias trail='cat -n <<<${(F)path}'
alias bbd='brew bundle dump --force --describe'
source "$DOTFILES/zsh/alias/git.zsh"

alias flutter="fvm flutter"
alias dart="fvm dart"

# Handle PATH
typeset -U path
path=(
  "$HOME/.cargo/bin"
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  $path
)

## PATH setting that uses homebrew-installed packages
path=(
  "$(go env GOPATH)/bin"
  "$HOME/fvm/default/bin"
  $path
)

eval "$(fnm env --use-on-cd)"

# Setup Starship
eval "$(starship init zsh)"

# Plugins
source "$DOTFILES/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
