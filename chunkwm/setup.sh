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

	log "ChunkWM/SKHD setup complete."
	printf "${newline}${newline}"
}

initialize