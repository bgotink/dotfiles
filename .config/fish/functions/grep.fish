function grep --description "grep, duh"
	which ggrep >/dev/null 2>&1; and ggrep --color=auto $argv; or command grep $argv;
end
