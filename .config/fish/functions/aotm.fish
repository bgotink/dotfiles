function aotm
        if which sl >/dev/null 2>&1
                sl $argv;
        else
                atom $argv;
        end
end
