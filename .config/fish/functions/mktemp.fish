function mktemp
    if which gmktemp >/dev/null 2>&1
        gmktemp $argv
    else
        command mktemp $argv
    end
end