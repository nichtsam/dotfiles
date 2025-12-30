#!/usr/bin/env zsh

echo "\n<<< Starting ZSH Setup >>>\n"

# Zsh is in brew's hands, so no need to worry about installation.
ZSH_PATH=$(which zsh)

if grep -Fxq $ZSH_PATH '/etc/shells'; then
  echo 'Brew-installed zsh already exists in /etc/shells'
else
  echo "Enter superuser (sudo) password to edit /etc/shells"
  echo $ZSH_PATH | sudo tee -a '/etc/shells' >/dev/null
fi


if [ $SHELL = $ZSH_PATH ]; then
  echo '$SHELL is already Brew-installed zsh'
else
  echo "Enter user password to change login shell"
  chsh -s $ZSH_PATH
fi
