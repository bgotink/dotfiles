function ls --description "List files"
    which gls >/dev/null ^/dev/null; and command gls --color=auto $argv; or command ls -G $argv
end