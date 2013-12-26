function rm
    if which grm >/dev/null 2>&1
        grm $argv
    else
        command rm $argv
    end
end