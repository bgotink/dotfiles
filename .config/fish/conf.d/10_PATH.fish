# set the different PATHs

set -x PATH /usr/bin /bin
eval "function _test; "(which test)" \$argv; end;"
set -e PATH

function _add_to_path
    _test -d $argv[1]; or return 1

    if _test $argv[1] = '/'
      set argv[1] ''
    end

    _test -d $argv[1]/bin; and set PATH $argv[1]/bin $PATH
    _test -d $argv[1]/sbin; and set PATH $argv[1]/sbin $PATH

    _test -d $argv[1]/include; and set INCLUDE_PATH $argv[1]/include $INCLUDE_PATH
    _test -d $argv[1]/lib; and set LD_LIBRARY_PATH $argv[1]/lib $LD_LIBRARY_PATH
    _test -d $argv[1]/share/man; and set MANPATH $argv[1]/share/man $MANPATH
end

set -gx PATH
set -gx MANPATH
set -gx INCLUDE_PATH
set -gx LD_LIBRARY_PATH

_add_to_path /
_add_to_path /usr
_add_to_path /usr/local
_add_to_path (python3 -m site --user-base)
_add_to_path /opt/homebrew
_add_to_path $N_PREFIX
if test -d $HOME/.cargo
  _add_to_path $HOME/.cargo
end
_add_to_path $HOME/.yarn
_add_to_path $HOME

functions -e _test
functions -e _add_to_path
