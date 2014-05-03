function git
    if which -s hub
        hub $argv
    else
        command git $argv
    end
end
