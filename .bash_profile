if [ -z "$PS1" ]; then
   return
fi

# fix the path
PATH=~/bin:/usr/local/share/npm/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/usr/sbin:/bin:/sbin

# bash completion, yay
if [ -f `brew --prefix`/etc/bash_completion ]; then
    . `brew --prefix`/etc/bash_completion
fi

if [ -f `brew --prefix`/etc/grc.bashrc ]; then
    . `brew --prefix`/etc/grc.bashrc
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
