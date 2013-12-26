function ls --description "List files"
    if which gls >/dev/null 2>&1
        gls --color=auto $argv
    else
        command ls --color=auto $argv
    end
end
