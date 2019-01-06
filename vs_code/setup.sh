#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
reset="$(tput sgr0)"

initialize() {
	read -r -p "${green}Install VS Code settings? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "${red}Installation declined${reset}"
		exit
	else
		setup_vscode
	fi
}

setup_vscode() {
	echo "${green}Installing VS Code settings...${reset}"

	if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
		rm $HOME/Library/Application\ Support/Code/User/settings.json
	fi

	echo "Symlinking settings.json..."
	ln -sf "$(pwd)/settings.json" $HOME/Library/Application\ Support/Code/User/settings.json

	echo "${green}VS Code settings installation complete.${reset}"
}

initialize