#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
cyan="$(tput setaf 6)"
reset="$(tput sgr0)"

log() {
	echo -e "${green}INFO: $1${reset}"
}

error() {
	echo -e "${red}ERROR: $1${reset}"
}

initialize() {
	read -r -p "${cyan}Setup chunkwm and skhd config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Setup declined..."
		error "Now exiting."
		exit
	else
		setup
	fi
}

setup() {
	echo -e "Setting up chunkwm and skhd config..."

	timestamp=$(date +"%Y%m%d-%H:%M:%S")

	if [ -f "$HOME/.chunkwmrc" ]; then
		log "Making backup of '$HOME/.chunkwmrc' to '$HOME/.chunkwmrc.backup.$timestamp'"
		mv $HOME/.chunkwmrc $HOME/.chunkwmrc.backup.$timestamp
	fi

	if [ -f "$HOME/.skhdrc" ]; then
		log "Making backup of '$HOME/.skhdrc' to '$HOME/.skhdrc.backup.$timestamp'"
		mv $HOME/.skhdrc $HOME/.skhdrc.backup.$timestamp
	fi

	log "Symlinking .chunkwmrc..."
	ln -sf "$(PWD)/.chunkwmrc" $HOME

	log "Symlinking .skhdrc..."
	ln -sf "$(PWD)/.skhdrc" $HOME

	echo -e "Setup complete."
}

initialize