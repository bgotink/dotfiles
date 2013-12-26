function pwd_prompt --description "Print pretty pwd"
	pwd | sed -e "s#^$HOME#~#"
end
