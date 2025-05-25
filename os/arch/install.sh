#!/bin/bash

set -e

# Install yay if not available
if ! command -v yay &> /dev/null; then
  echo "Installing yay..."
  git clone https://aur.archlinux.org/yay.git /tmp/yay
  pushd /tmp/yay
  makepkg -si --noconfirm
  popd
fi

# Install packages from Yayfile
echo "Installing packages..."
yay -S --noconfirm $(grep -vE '^\s*$|^#' "$(dirname "$0")/Yayfile")

# Clean up yay build files
rm -rf /tmp/yay
