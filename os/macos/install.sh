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

echo "--------------------------------"
echo "Configuring OS"
echo "--------------------------------"
echo "Enabling menu tray icon defaults"
defaults write com.apple.systemuiserver menuextras -array \
  "/system/library/coreservices/menu extras/bluetooth.menu" \
  "/system/library/coreservices/menu extras/airport.menu" \
  "/system/library/coreservices/menu extras/volume.menu" \
  "/system/library/coreservices/menu extras/battery.menu"

echo "Enabling text selection in quicklook"
defaults write com.apple.finder qlenabletextselection -bool true

echo "Setting column view as Finder default"
defaults write com.apple.finder fxpreferredviewstyle -string "clmv"

echo "Disabling extension change warning in finger"
defaults write com.apple.finder fxenableextensionchangewarning -bool false

echo "Setting Finder to show full path in title"
defaults write com.apple.finder _fxshowposixpathintitle -bool true

echo "Showing all Finder extensions"
defaults write nsglobaldomain appleshowallextensions -bool true

echo "Showing Finder statusbar"
defaults write com.apple.finder showstatusbar -bool true

echo "Showing ~/Library"
chflags nohidden ~/library

echo "Setting inteface style to dark granite"
defaults write nsglobaldomain appleenablemenubartransparency -int 0
defaults write nsglobaldomain appleinterfacestyle dark
defaults write nsglobaldomain appleaquacolorvariant -int 6
defaults write nsglobaldomain applehighlightcolor -string "0.780400 0.815700 0.858800"

echo "Setting dock to minimal and hidden"
defaults write com.apple.dock no-glass -bool true
defaults write com.apple.dock autohide-delay -float 0.1
defaults write com.apple.dock autohide -int 1
defaults write com.apple.dock tilesize -int 68
defaults write com.apple.dock size-immutable -bool yes
defaults write com.apple.dock mineffect scale

echo "Speeding up animations"
defaults write -g nswindowresizetime -float 0.001
defaults write com.apple.dock autohide-time-modifier -float 0.25
defaults write NSGlobalDomain NSAutomaticWindowAnimationsEnabled -bool false
defaults write -g QLPanelAnimationDuration -float 0.25
defaults write com.apple.finder DisableAllAnimations -bool true
defaults write com.apple.dock expose-animation-duration -float 0.25

echo "Speeding up keyboard repeat"
defaults write NSGlobalDomain InitialKeyRepeat -int 15
defaults write NSGlobalDomain KeyRepeat -int 2

echo "Setting save panel to always be in expaneded mode"
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode -int 1;
defaults write NSGlobalDomain NSNavPanelExpandedStateForSaveMode2 -int 1

killall Dock
killall Finder

echo "Disabling autocorrect, use Alfred"
defaults write NSGlobalDomain NSAutomaticSpellingCorrectionEnabled -bool false


echo "Setting up Screenshots directory"
mkdir -p ~/Screenshots
defaults write com.apple.screencapture location ~/Screenshots

echo "Setting up Safari developer tools"
defaults write com.apple.Safari IncludeInternalDebugMenu -bool true
defaults write com.apple.Safari IncludeDevelopMenu -bool true
defaults write com.apple.Safari WebKitDeveloperExtrasEnabledPreferenceKey -bool true
defaults write com.apple.Safari "com.apple.Safari.ContentPageGroupIdentifier.WebKit2DeveloperExtrasEnabled" -bool true
defaults write NSGlobalDomain WebKitDeveloperExtras -bool true
defaults write com.apple.appstore ShowDebugMenu -bool true

