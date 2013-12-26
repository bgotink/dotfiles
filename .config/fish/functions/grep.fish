function grep --description "grep, duh"
	if which ggrep > /dev/null 2>&1
		ggrep --color=auto $argv
	else
		command grep $argv
	end
end
