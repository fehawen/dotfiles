#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
reset="$(tput sgr0)"

initialize() {
	read -r -p "${green}Install Hyper terminal settings? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "${red}Installation declined${reset}"
		exit
	else
		setup_hyper
	fi
}

setup_hyper() {
	echo "${green}Installing Hyper terminal settings...${reset}"

	if [ -f $HOME/.hyper.js ]; then
		rm $HOME/.hyper.js
	fi

	echo "Symlinking .hyper.js..."
	ln -sf "$(pwd)/.hyper.js" $HOME/.hyper.js

	echo "${green}Hyper terminal settings installation complete.${reset}"
}

initialize