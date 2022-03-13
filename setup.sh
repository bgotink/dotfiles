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
  if ! [ $file = .git -o $file = extra -o $file = setup.sh -o $file = .config -o $file = README.md ]
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
###

# Make Finder quitable
defaults write com.apple.finder QuitMenuItem -bool true
