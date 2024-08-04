function git
    if test $argv[1] = "cd"
        cd (command git rev-parse --show-toplevel)
        return
    end

    command git $argv
end
