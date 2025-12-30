DOTFILES_SSH="$HOME/.dotfiles/ssh_config"
SSH_CONFIG_DIR="$HOME/.ssh"
SSH_CONFIG_FILE="$SSH_CONFIG_DIR/config"
INCLUDE_LINE="Include $DOTFILES_SSH"

mkdir -p "$SSH_CONFIG_DIR"
touch "$SSH_CONFIG_FILE"

if ! grep -q "$INCLUDE_LINE" "$SSH_CONFIG_FILE"; then
  {
    echo "$INCLUDE_LINE"
    if [ -s "$SSH_CONFIG_FILE" ]; then
      echo
    fi
    cat "$SSH_CONFIG_FILE"
  } >"$SSH_CONFIG_FILE.tmp"

  mv "$SSH_CONFIG_FILE.tmp" "$SSH_CONFIG_FILE"
fi
