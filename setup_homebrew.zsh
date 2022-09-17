#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

# check if brew exist 
# https://stackoverflow.com/a/677212
if command -v brew >/dev/null 2>&1; then
  echo "Brew exists, skipping install"
else
  echo "Brew doesn't exist, continuing with install"
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

brew bundle --verbose
