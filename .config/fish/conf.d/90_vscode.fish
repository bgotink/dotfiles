if string match -q "$TERM_PROGRAM" "vscode"
	. (code --locate-shell-integration-path fish)
end
