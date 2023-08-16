#!/usr/bin/env sh
# install homebrew
if [[ ! -x "$(command -v brew)" ]]; then
  echo "Installing homebrew...\\n"
    /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
  echo 'eval "$(/opt/homebrew/bin/brew shellenv)"' >> /Users/julian/.zprofile
  eval "$(/opt/homebrew/bin/brew shellenv)"
else
  echo "Homebrew is already installed.\\n"
fi

echo "Installing packages"
echo $(pwd)
brew bundle --file ~/repos/jinwood/dotfiles/os/macos/Brewfile
