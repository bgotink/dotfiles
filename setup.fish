#!/usr/bin/env fish

set dir (cd (dirname (status filename)) && pwd | sed -e "s#$HOME/##")

cd ~

for i in $dir/* $dir/.*
  set file (basename $i)
  if ! [ $file = .git -o $file = extra -o $file = setup.fish ]
    echo "Linking $i -> ~/$file"
    ln -sf $i
  end
end

# Make the fish prompt more verbose
set -U __fish_git_prompt_showdirtystate 1
set -U __fish_git_prompt_showuntrackedfiles 1
set -U __fish_git_prompt_showupstream 1

# Make Finder quitable
defaults write com.apple.finder QuitMenuItem -bool true

