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
	read -r -p "${cyan}Setup VS Code config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "VS Code setup declined..."
		error "Now exiting."
		printf "${newline}${newline}"
		exit
	else
		setup
	fi
}

setup() {
	log "Setting up VS Code config..."

	if [ -f $HOME/Library/Application\ Support/Code/User/settings.json ]; then
		rm $HOME/Library/Application\ Support/Code/User/settings.json
	fi

	log "Symlinking settings.json..."
	ln -sf "$(pwd)/settings.json" $HOME/Library/Application\ Support/Code/User/settings.json

	log "VS Code setup complete."
	printf "${newline}${newline}"
}

initialize