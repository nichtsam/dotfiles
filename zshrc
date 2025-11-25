# Set variables
export LANG=en_US.UTF-8
export DOTFILES="$HOME/.dotfiles"
export HOMEBREW_BUNDLE_FILE="$DOTFILES/Brewfile"

# Enable Auto-Completion
autoload -Uz compinit
today=$(date +'%j')
compdump_day=$(stat -f '%Sm' -t '%j' ~/.zcompdump 2>/dev/null)
if [ "$compdump_day" != "$today" ]; then
  rm -f ~/.zcompdump # don't know why compinit isn't updating this
  compinit
else
  compinit -C
fi

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

# Mise Runtimes Paths
eval "$(mise activate zsh)"

# Setup Starship
eval "$(starship init zsh)"

# Plugins
source "$DOTFILES/zsh/zsh-autosuggestions/zsh-autosuggestions.zsh"
