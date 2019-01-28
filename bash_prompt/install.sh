#!/bin/bash

source $(PWD)/setup.sh

clone() {
	echo -e "${cyan}If you wish to clone this repo into a specific location, please specify the path below."
	echo -e "Else press 'Enter' to clone into: '$(PWD)/dotfiles'"

	read -r -p "${cyan}PATH:${reset} " clonepath

	if [[ $clonepath == "" ]]; then
		log "Cloning fehawen/dotfiles to '$(PWD)/dotfiles'"
		git clone https://github.com/fehawen/dotfiles.git
	else
		log "Cloning fehawen/dotfiles to '${clonepath}/dotfiles'"
		git clone https://github.com/fehawen/dotfiles.git ${clonepath}/dotfiles
	fi
}

next() {
	command $(PWD)/setup.sh
}

clone
next