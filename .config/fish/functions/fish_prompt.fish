function fish_prompt --description "Write the prompt"
    set_color green
    echo -n $USER
    if echo $HOST | grep -v -q -E $USER".*"
        # other host (SSH) or other user
        echo -n "@"$HOST
    end
    echo -n ":"; set_color blue; echo -n (pwd_prompt); set_color cyan; __fish_git_prompt ' (%s) '
    set_color normal; echo -n '$ '
end
