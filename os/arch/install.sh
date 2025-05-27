#!/bin/bash

set -e

# Install yay if not available
if ! command -v yay &>/dev/null; then
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

echo "Setting up Hyprland..."
mkdir -p ~/.config/hypr
ln -sf "$SCRIPT_ROOT/os/arch/hypr/hyprland.conf" ~/.config/hypr/hyprland.conf
ln -sf "$SCRIPT_ROOT/os/arch/hypr/hyprpaper.conf" ~/.config/hypr/hyprpaper.conf

echo "Setting up Waybar..."
mkdir -p ~/.config/waybar
ln -sf "$SCRIPT_ROOT/os/arch/waybar/config.jsonc" ~/.config/waybar/config.jsonc
ln -sf "$SCRIPT_ROOT/os/arch/waybar/style.css" ~/.config/waybar/style.css
ln -sf "$SCRIPT_ROOT/os/arch/waybar/power_menu.xml" ~/.config/waybar/power_menu.xml

echo "Linking Xmodmap..."
ln -sf "$SCRIPT_ROOT/os/arch/.Xmodmap" ~/.Xmodmap

echo "Installing hypr-related utilities..."
yay -S --needed hyprpaper waybar rofi wofi dunst brightnessctl xdg-desktop-portal-hyprland xwaylandvideobridge cliphist wl-clipboard swaylock-effects

echo "Add 'Hyprland' to your display manager session or set up ~/.xinitrc to start Hyprland"
