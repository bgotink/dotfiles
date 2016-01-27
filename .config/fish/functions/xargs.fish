function xargs --description "xargs, duh"
        if which gxargs > /dev/null 2>&1
                gxargs $argv
        else
                command grep $argv
        end
end
