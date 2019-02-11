#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
reset="$(tput sgr0)"

newline='
'

log() {
	printf "${green}INFO: $1${reset}"
}

error() {
	printf "${red}ERROR: $1${reset}"
}

initialize() {
	printf "${newline}"
	read -r -p "${cyan}Setup hyper config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Setup declined..."
		error "Now exiting."
		exit
	else
		setup
	fi
}

setup() {
	log "${green}Setting up hyper config...${reset}"

	if [ -f $HOME/.hyper.js ]; then
		rm $HOME/.hyper.js
	fi

	log "Symlinking .hyper.js..."
	ln -sf "$(pwd)/.hyper.js" $HOME/.hyper.js

	log "Setup complete."
	printf "${newline}"
}

initialize