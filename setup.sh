#!/usr/bin/env bash

set -e

dir="$(cd "$(dirname "$0")" && pwd | sed -e "s#$HOME/##")"

###
# Install homebrew if not installed yet
###

if ! command -v brew >/dev/null 2>&1
then
  bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

###
# Install dependencies
###

cd "$(dirname "$0")/extra"
brew bundle

###
# Link dotfiles
###

# Mask all newly created files
original_umask="$(umask)"
umask 077

cd ~

for i in "$dir"/* "$dir"/.*
do
  file="$(basename "$i")"
  if ! [ $file = . -o $file = .. -o $file = .git -o $file = extra -o $file = setup.sh -o $file = .config -o $file = README.md ]
  then
    echo "Linking $i -> ~/$file"
    ln -sf "$i"
  fi
done

mkdir -p .config
pushd .config >/dev/null 2>&1
for i in "../$dir"/.config/*
do
  echo "Linking $i -> ~/.config/$(basename $i)"
  ln -sf "$i"
done
popd >/dev/null 2>&1

mkdir -p .gnupg
pushd .gnupg >/dev/null 2>&1
for i in "../$dir"/extra/gnupg/*
do
  echo "Linking $i -> ~/.gnupg/$(basename $i)"
  ln -sf "$i"
done
popd >/dev/null 2>&1

mkdir -p Workspace

# undo umask
umask "$original_umask"

###
# Configure macOS
#
# See https://macos-defaults.com/ for info on the defaults
###

# Configure FISH as shell

FISH="$(which fish)"
if ! grep --quiet "$FISH" /etc/shells
then
  echo "Adding $FISH to the /etc/shells file" >&2
  echo "$FISH" | sudo tee -a /etc/shells
fi

defaultShell="$(dscl . -read ~/ UserShell | sed 's/UserShell: //')"
if [[ "$defaultShell" != "$FISH" ]]
then
  chsh -s "$FISH"
fi

# General

# UI theme → dark mode
defaults write -globalDomain AppleInterfaceStyle "Dark"
# Disable spelling correction
defaults write -globalDomain NSAutomaticSpellingCorrectionEnabled -boolean false
# Disable automatic capitalization
defaults write -globalDomain NSAutomaticCapitalizationEnabled -boolean false
# Disable things that annoy developers
defaults write -globalDomain NSAutomaticCapitalizationEnabled -boolean false
defaults write -globalDomain NSAutomaticDashSubstitutionEnabled -boolean false
defaults write -globalDomain NSAutomaticPeriodSubstitutionEnabled -boolean false
defaults write -globalDomain NSAutomaticQuoteSubstitutionEnabled -boolean false

# Dock

# Autohide dock
defaults write com.apple.dock autohide -boolean true
# Move dock to the left
defaults write com.apple.dock orientation left
# Turn off magnification
defaults write com.apple.dock magnification -boolean false
# Minimize apps to the app logo
defaults write com.apple.dock minimize-to-application -boolean true
# Do not show recent applications
defaults write com.apple.dock show-recents -bool false
# Do not re-order spaces based on most recently used
defaults write com.apple.dock mru-spaces -bool false

# Gestures

# Click by tapping
defaults write com.apple.AppleMultitouchTrackpad Clicking -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad Clicking -boolean true
# Three finger drag
defaults write com.apple.AppleMultitouchTrackpad TrackpadThreeFingerDrag -boolean true
defaults write com.apple.driver.AppleBluetoothMultitouch.trackpad TrackpadThreeFingerDrag -boolean true
# Enable expose gesture
defaults write com.apple.dock showAppExposeGestureEnabled -boolean true

# Finder

# Don't show the tags
defaults write com.apple.finder ShowRecentTags -boolean false
# Preferred view style → three columns
defaults write com.apple.finder FXPreferredViewStyle -string "clmv"
# Location for new window → home folder
defaults write com.apple.finder NewWindowTarget PfHm
defaults write com.apple.finder NewWindowTargetPath "file://$HOME"
# Make Finder quitable
defaults write com.apple.finder QuitMenuItem -boolean true

# Menu

# Add extra items to system menu
defaults write com.apple.systemuiserver menuExtras -array \
  "/System/Library/CoreServices/Menu Extras/Bluetooth.menu" \
  "/System/Library/CoreServices/Menu Extras/Clock.menu" \
  "/System/Library/CoreServices/Menu Extras/Displays.menu" \
  "/System/Library/CoreServices/Menu Extras/Volume.menu"
