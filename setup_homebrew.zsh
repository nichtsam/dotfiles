#!/usr/bin/env zsh

echo "\n<<< Starting Homebrew Setup >>>\n"

# TODO: add condition to avoid excessive curl
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"

brew bundle --verbose
