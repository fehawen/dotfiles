#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
yellow="$(tput setaf 3)"
cyan="$(tput setaf 6)"
reset="$(tput sgr0)"
newline='
'

log() {
	echo -e "${green}INFO: $1${reset}"
}

clone() {
	echo -e "${cyan}If you wish to clone this repo into a specific location, please specify the path below."
	echo -e "Else press 'Enter' to clone into: '$(PWD)/dotfiles'"

	read -r -p "${cyan}PATH:${reset} " clonepath

	if [ "$clonepath" != "" ]; then
		log "Cloning fehawen/dotfiles to '${clonepath}/dotfiles'"
		git clone https://github.com/fehawen/dotfiles.git $clonepath
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