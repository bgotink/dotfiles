function sed
    if which gsed > /dev/null 2>&1
        gsed $argv
    else
        command sed $argv
    end
end