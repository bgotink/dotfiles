function chown
    if which gchown >/dev/null 2>&1
        gchown $argv
    else
        command chown $argv
    end
end