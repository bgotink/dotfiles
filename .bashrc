# useful function

__which() {
    if type "$1" > /dev/null 2>&1; then
        return 0;
    else
        return 1;
    fi
}

# set HAVE_BREW if not set already

[ -z $HAVE_BREW ] && HAVE_BREW=$(__which brew && echo '1' || echo '0');

# bash completion, yay

BASH_COMPLETED=0;

if [ $HAVE_BREW -eq 1 ]; then
    if [ -f $(brew --prefix)/etc/bash_completion ]; then
        . $(brew --prefix)/etc/bash_completion;
        BASH_COMPLETED=1;
    fi

    if [ -f $(brew --prefix)/etc/grc.bashrc ]; then
        . $(brew --prefix)/etc/grc.bashrc
    fi
fi

if [ $BASH_COMPLETED -eq 0 ]; then
    if [ -f /etc/bash_completion ]; then
        . /etc/bash_completion;
    elif [ -f /opt/local/etc/bash_completion ]; then
        . /opt/local/etc/bash_completion;
    fi
fi

unset BASH_COMPLETED;

# bigger history file
HISTFILESIZE=1000
# no duplicate commands in history
HISTCONTROL=ignoredups

# set PS1

HOSTNAME=$(uname -n);
case $HOSTNAME in
    $USER|$USER.local)
        PS1_HOSTNAME=''
        ;;
    *)
        PS1_HOSTNAME='@\h'
        ;;
esac

if [[ ${EUID} == 0 ]] ; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u'"$PS1_HOSTNAME"'\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '  
else
    if __which __git_ps1; then
        export GIT_PS1_SHOWDIRTYSTATE=1
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u'"$PS1_HOSTNAME"'\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;36m\]$(__git_ps1 " (%s) ")\[\033[00m\]\$ '
    else
        PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u'"$PS1_HOSTNAME"'\[\033[00m\]:\[\033[01;34m\]\w\[\033[01;36m\]\[\033[00m\]\$ '
    fi
fi

unset PS1_HOSTNAME HOSTNAME;

UNAME=$(uname -s);

if [ $UNAME == "Darwin" ]; then
    if [ ${BASH_VERSION:0:1} -eq 3 ]; then
    	export BASH_TYPE='OSX'
    else
    	export BASH_TYPE='GNU'
    fi
else
    export BASH_TYPE='GNU';
fi

if [ -d /usr/local/share/npm/lib/node_modules ]; then
    export NODE_PATH=/usr/local/share/npm/lib/node_modules
fi

# i18n tweaks
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# yes, I want colors
export CLICOLOR=1

# Make bash check its window size after a process completes
shopt -s checkwinsize
# Tell the terminal about the working directory at each prompt.
if [ "$TERM_PROGRAM" == "Apple_Terminal" ] && [ -z "$INSIDE_EMACS" ]; then
    update_terminal_cwd() {
        # Identify the directory using a "file:" scheme URL,
        # including the host name to disambiguate local vs.
        # remote connections. Percent-escape spaces.
	local SEARCH=' '
	local REPLACE='%20'
	local PWD_URL="file://$HOSTNAME${PWD//$SEARCH/$REPLACE}"
	printf '\e]7;%s\a' "$PWD_URL"
    }
    PROMPT_COMMAND="update_terminal_cwd; $PROMPT_COMMAND"
fi
								    
export EDITOR=nano

# some aliases

if ! __which 'shred'; then
    if __which 'srm'; then
        alias shred='srm --medium'
    fi
fi

if [ $BASH_TYPE == "GNU" ]; then
    if [ $UNAME == "Darwin" ]; then
    	# Use the GNU ls (cf. linux) because it has better color support
    	__which gls && alias ls='gls --color=auto'

    	# Use GNU rm, because that allows using rm /tmp/test -rf, thus ensuring you don't have to type rm -rf /
    	__which grm && alias rm='grm'

    	# User the GNU mktemp, because it doesn't require any arguments
    	__which gmktemp && alias mktemp='gmktemp'

    	# sed -i -e doesn't quite work
    	__which gsed && alias sed='gsed'

    	# chown requires ':', gchown doesn't
    	__which gchown && alias chown='gchown'

    	# I'm used to 'cp -varx' to copy directories, which doesn't work with the BSD cp
    	__which gcp && alias cp='gcp'
    fi
    
	alias l='ls -F'
else
	alias ls='ls -G'
	alias l='ls -f'
fi

# load extra aliases if defined
[ -f ~/.bash_aliases ] && . ~/.bash_aliases;

# make GREP use colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'

# show a fortune cookie :-)
__which fortune && fortune;

unset UNAME __which HAVE_BREW;