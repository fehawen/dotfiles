#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
reset="$(tput sgr0)"

newline='
'

log() {
	printf "${newline}${green}INFO: $1${reset}"
}

error() {
	printf "${newline}${red}ERROR: $1${reset}"
}

initialize() {
	printf "${newline}"
	read -r -p "${cyan}Setup Hyper config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Hyper setup declined..."
		error "Now exiting."
		printf "${newline}${newline}"
		exit
	else
		setup
	fi
}

setup() {
	log "${green}Setting up Hyper config...${reset}"

	if [ -f $HOME/.hyper.js ]; then
		rm $HOME/.hyper.js
	fi

	log "Symlinking .hyper.js..."
	ln -sf "$(pwd)/.hyper.js" $HOME/.hyper.js

	log "Hyper setup complete."
	printf "${newline}${newline}"
}

initialize