function find --description "find, duh"
        if which gfind > /dev/null 2>&1
                gfind $argv
        else
                command find $argv
        end
end
