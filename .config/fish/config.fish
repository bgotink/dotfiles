set -x HOST (hostname)

function _add_to_path
    test -d $argv[1]; or return 1

    if test $argv[1] = '/'
        set argv[1] ''
    end
    
    test -d $argv[1]/sbin; and set PATH $PATH $argv[1]/sbin
    test -d $argv[1]/bin; and set PATH $PATH $argv[1]/bin
    test -d $argv[1]/include; and set INCLUDE_PATH $INCLUDE_PATH $argv[1]/include
    test -d $argv[1]/lib; and set LD_LIBRARY_PATH $LD_LIBRARY_PATH $argv[1]/lib
    test -d $argv[1]/share/man; and set MANPATH $MANPATH $argv[1]/share/man
end

set -x PATH
set -x MANPATH
set -x INCLUDE_PATH
set -x LD_LIBRARY_PATH

_add_to_path /Users/bram
_add_to_path /usr/local
_add_to_path /usr/local/share/npm
_add_to_path /usr
_add_to_path /

functions -e _add_to_path

if status -i
    which fortune >/dev/null ^&1; and fortune;
end 
