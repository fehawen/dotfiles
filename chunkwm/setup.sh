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
	read -r -p "${cyan}Setup ChunkWM/SKHD config? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "ChunkWM/SKHD setup declined..."
		error "Now exiting."
		printf "${newline}${newline}"
		exit
	else
		setup
	fi
}

setup() {
	log "Setting up ChunkWM/SKHD config..."

	timestamp=$(date +"%Y%m%d-%H:%M:%S")

	if [ -f "$HOME/.config/chunkwm/.chunkwmrc" ] && [ ! -L "$HOME/.config/chunkwm/.chunkwmrc" ]; then
		log "Making backup of '$HOME/.config/chunkwm/.chunkwmrc' to '$HOME/.config/chunkwm/.chunkwmrc.backup.$timestamp'"
		mv $HOME/.chunkwmrc $HOME/.chunkwmrc.backup.$timestamp
	fi

	if [ -f "$HOME/.config/chunkwm/.skhdrc" ] && [ ! -L "$HOME/.config/chunkwm/.skhdrc" ]; then
		log "Making backup of '$HOME/.config/chunkwm/.skhdrc' to '$HOME/.config/chunkwm/.skhdrc.backup.$timestamp'"
		mv $HOME/.skhdrc $HOME/.skhdrc.backup.$timestamp
	fi

	log "Symlinking .chunkwmrc..."
	ln -sf "$(PWD)/.chunkwmrc" $HOME/.config/chunkwm/.chunkwmrc

	log "Symlinking .skhdrc..."
	ln -sf "$(PWD)/.skhdrc" $HOME/.config/chunkwm/.skhdrc

	log "ChunkWM/SKHD setup complete."
	printf "${newline}${newline}"
}

initialize