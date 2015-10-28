# display fortune if applicable

if status -i
    which fortune >/dev/null ^&1; and fortune;
end 
