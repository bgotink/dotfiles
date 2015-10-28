# set $HOST

set -x HOST (hostname)

# set the different PATH's

set -x PATH '/usr/bin' '/bin'
eval "function _test; "(which test)" \$argv; end;"
set -e PATH

function _add_to_path
    _test -d $argv[1]; or return 1

    if _test $argv[1] = '/'
        set argv[1] ''
    end

    _test -d $argv[1]/bin; and set PATH $PATH $argv[1]/bin
    _test -d $argv[1]/sbin; and set PATH $PATH $argv[1]/sbin

    _test -d $argv[1]/include; and set INCLUDE_PATH $INCLUDE_PATH $argv[1]/include
    _test -d $argv[1]/lib; and set LD_LIBRARY_PATH $LD_LIBRARY_PATH $argv[1]/lib
    _test -d $argv[1]/share/man; and set MANPATH $MANPATH $argv[1]/share/man
end

set -gx PATH
set -gx MANPATH
set -gx INCLUDE_PATH
set -gx LD_LIBRARY_PATH

_add_to_path $HOME
_add_to_path /usr/local
_add_to_path /usr/local/share/npm
_add_to_path /usr
_add_to_path /

functions -e _test
functions -e _add_to_path

# Load global configuration files

if test -d ~/.config/fish/global
    for file in (ls ~/.config/fish/global)
        source ~/.config/fish/global/$file
    end
end

# load local configuration files

if test -d ~/.config/fish/local
    for file in (ls ~/.config/fish/local)
        source ~/.config/fish/local/$file
    end
end
