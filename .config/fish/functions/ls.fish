function ls --description "List files"
    if which gls >/dev/null 2>&1
        gls $argv
    else
        command ls $argv
    end
end