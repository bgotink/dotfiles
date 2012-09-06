if [[ ${EUID} == 0 ]] ; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '  
else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
fi

if [ ${BASH_VERSION:0:1} -eq 3 ]; then
	export BASH_TYPE='OSX'
else
	export BASH_TYPE='GNU'
fi

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

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

alias shred='srm --medium'

if [ $BASH_TYPE = 'GNU' ]; then
	# Use the GNU ls (cf. linux) because it has better color support
	alias ls='gls --color=auto'
	alias l='ls -F'

	# Use GNU rm, because that allows using rm /tmp/test -rf, thus ensuring you don't have to type rm -rf /
	alias rm='grm'

	# Use the GNU ln, because typing 'ln -s ../brol .' is easier than 'ln -s ../brol brol'
	alias ln='gln'

	# User the GNU mktemp, because it doesn't require any arguments
	alias mktemp='gmktemp'
else
	alias ls='ls -G'
	alias l='ls -f'
fi

# make GREP use colors
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
