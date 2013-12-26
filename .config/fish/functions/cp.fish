function cp
    if which gcp >/dev/null 2>&1
        gcp $argv
    else
        command cp $argv
    end
end