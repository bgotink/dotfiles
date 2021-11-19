#!/usr/bin/env fish

set dir (cd (dirname (status filename)) && pwd | sed -e "s#$HOME/##")

# Mask all newly created files
set original_umask (umask)
umask 077

cd ~

for i in $dir/* $dir/.*
  set file (basename $i)
  if ! [ $file = .git -o $file = extra -o $file = setup.fish -o $file = .config ]
    echo "Linking $i -> ~/$file"
    ln -sf $i
  end
end

mkdir -p .config
pushd .config
for i in ../$dir/.config/*
  echo "Linking $i -> ~/.config/"(basename $i)
  ln -sf $i
end
popd

mkdir -p .gnupg
pushd .gnupg
for i in ../$dir/extra/gnupg/*
  echo "Linking $i -> ~/.gnupg/"(basename $i)
  ln -sf $i
end
popd

mkdir -p Workspace

# undo umask
umask $original_umask

# Make the fish prompt more verbose
set -U __fish_git_prompt_showdirtystate 1
set -U __fish_git_prompt_showuntrackedfiles 1
set -U __fish_git_prompt_showupstream 1

# Make Finder quitable
defaults write com.apple.finder QuitMenuItem -bool true
