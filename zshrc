# Set variables
export LANG=en_US.UTF-8
export DOTFILES="$HOME/.dotfiles"
export HOMEBREW_BUNDLE_FILE="$DOTFILES/Brewfile"

# Auto-Completion
autoload -U compinit; compinit

# Alias
alias ls='lsd -lg'
alias tree='lsd --tree'
alias trail='cat -n <<<${(F)path}'
alias bbd='brew bundle dump --force --describe'
source "$DOTFILES/zsh/alias/git.zsh"

# Handle PATH
typeset -U path
path=(
  "/opt/homebrew/bin"
  "/opt/homebrew/sbin"
  $path
)

## PATH setting that uses homebrew-installed packages
path=(
  $path
)

# Mise Runtimes Paths
eval "$(mise activate zsh)"

# Setup Starship
eval "$(starship init zsh)"

# Plugins
source "$DOTFILES/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
