function fish_prompt --description "Write the prompt"
    if test (whoami) != 'root'
        set_color green
    else
        if test $HOME = /root
            set_color yellow
        else
            set_color red
        end
    end
    echo -n $USER
    if echo $HOST | grep -vi -q -E $USER".*"
        # other host (SSH) or other user
        echo -n "@"$HOST
    end
    echo -n ":"; set_color blue; echo -n (pwd_prompt); set_color cyan; __fish_git_prompt ' (%s) '
    set_color normal; echo -n '$ '
end
