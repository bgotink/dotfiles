if [ -z "$PS1" ]; then
   return
fi

getPath() {
if [ -d "$1" ]; then
    if [ -d "$1"/bin ]; then
        echo -n "$1/bin:"
    fi
    if [ -d "$1"/sbin ]; then
        echo -n "$1/sbin:"
    fi
fi
}

# fix the path
PATH=$(getPath $HOME)$(getPath /usr/local/share/npm)$(getPath /usr/local)$(getPath /opt/local)$(getPath /usr)/bin:/sbin

# fix the manpath
MANPATH=/usr/local/share/man:/opt/local/share/man:/usr/share/man

# fix the include path
INCLUDE_PATH=/usr/local/include:/opt/local/include:/usr/include

if [ -f `brew --prefix`/etc/grc.bashrc ]; then
    . `brew --prefix`/etc/grc.bashrc
fi

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi
