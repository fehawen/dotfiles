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
	read -r -p "${cyan}Setup vs-code config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Setup declined..."
		error "Now exiting."
		exit
	else
		setup
	fi
}

setup() {
	log "Setting up vs-code config..."

	if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
		rm $HOME/Library/Application\ Support/Code/User/settings.json
	fi

	log "Symlinking settings.json..."
	ln -sf "$(pwd)/settings.json" $HOME/Library/Application\ Support/Code/User/settings.json

	log "Setup complete."
	printf "${newline}"
}

initialize