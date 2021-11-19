# display fortune if applicable

function fish_greeting
    if status -i
        which fortune >/dev/null 2>&1; and fortune;
    end
end
