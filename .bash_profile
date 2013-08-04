if [ -z "$PS1" ]; then
   return
fi

PATH=''
MANPATH=''
INCLUDE_PATH=''

__addToPath() {
    if [ -d "$1" ]; then
        local dir="${1%/}"
        
        if [ -d "$dir"/sbin ]; then
            PATH=":$dir/sbin$PATH";
        fi
        if [ -d "$dir"/bin ]; then
            PATH=":$dir/bin$PATH";
        fi
    
        if [ -d "$dir"/share/man ]; then
            MANPATH=":$dir/share/man$MANPATH";
        fi
    
        if [ -d "$dir"/include ]; then
            INCLUDE_PATH=":$dir/include$INCLUDE_PATH";
        fi
    fi
}

# fix the paths
__addToPath /;
__addToPath /usr;
__addToPath /opt/local;
__addToPath /usr/local;
__addToPath /usr/local/share/npm;
__addToPath "$HOME";

unset __addToPath;

PATH="${PATH:1}";
MANPATH="${MANPATH:1}";
INCLUDE_PATH="${INCLUDE_PATH:1}";

export PATH MANPATH INCLUDE_PATH;

HAVE_BREW=$(which brew > /dev/null 2>&1 && echo "1" || echo "0");
export HAVE_BREW;

if [ -f ~/.bashrc ]; then
    . ~/.bashrc
fi

unset HAVE_BREW;
