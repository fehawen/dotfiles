#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
reset="$(tput sgr0)"
newline='
'

log() {
	echo -e "${green}INFO: $1${reset}"
}

clone() {
	read -r -p "${cyan}If you wish to clone this repo into a specific location, please specify the path.${newline}Else press 'Enter' to clone into: '$(PWD)/dotfiles'${newline}PATH:${reset} " answer
	if [ "$answer" != "" ]; then
		log "Cloning fehawen/dotfiles to '${clonepath}/dotfiles'"
		git clone https://github.com/fehawen/dotfiles.git ${clonepath}/dotfiles
		next "${clonepath}/dotfiles/bash_prompt/setup.sh"
	else
		log "Cloning fehawen/dotfiles to '$(PWD)/dotfiles'"
		git clone https://github.com/fehawen/dotfiles.git
		next "$(PWD)/dotfiles/bash_prompt/setup.sh"
	fi

	next
}

next() {
	command $1
}

clone