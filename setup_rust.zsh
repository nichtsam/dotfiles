#!/usr/bin/env zsh

echo "\n<<< Starting Rust Setup >>>\n"

if exists rustup; then
  echo "Rust exists, skipping install"
else
  echo "Rust doesn't exist, continuing with install"
  # Rust official doc's installation script: https://doc.rust-lang.org/book/ch01-01-installation.html#installing-rustup-on-linux-or-macos
  # path is handled by .zshrc
  curl --proto '=https' --tlsv1.3 https://sh.rustup.rs -sSf | sh -s -- -y --no-modify-path
fi

