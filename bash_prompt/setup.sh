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
	read -r -p "${cyan}Setup Bash prompt? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		error "Bash prompt setup declined..."
		error "Now exiting."
		printf "${newline}${newline}"
		exit
	else
		setup
	fi
}

setup() {
	log "Setting up Bash prompt..."

	timestamp=$(date +"%Y%m%d-%H:%M:%S")

	if [ -f "$HOME/.bashrc" ] && [ ! -L "$HOME/.bashrc" ]; then
		log "Making backup of '$HOME/.bashrc' to '$HOME/.bashrc.backup.$timestamp'"
		mv $HOME/.bashrc $HOME/.bashrc.backup.$timestamp
	fi

	if [ -f "$HOME/.bash_profile" ] && [ ! -L "$HOME/.bash_profile" ]; then
		log "Making backup of '$HOME/.bash_profile' to '$HOME/.bash_profile.backup.$timestamp'"
		mv $HOME/.bash_profile $HOME/.bash_profile.backup.$timestamp
	fi

	log "Symlinking .bashrc..."
	ln -sf "$(PWD)/.bashrc" $HOME

	log "Symlinking .bash_profile..."
	ln -sf "$(PWD)/.bash_profile" $HOME

	log "Symlinking .hushlogin for muted terminal login message..."
	ln -sf "$(PWD)/.hushlogin" $HOME

	log "Checking which shell..."
	if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
		log "Shell is already set to $SHELL"
	else
		error "Shell is set to $SHELL"
		log "Changing shell to /bin/bash"
		chsh -s /bin/bash
	fi

	log "Bash prompt setup complete."
	printf "${newline}Enter ${cyan}source ~/.bashrc${reset} to reload prompt."
	printf "${newline}${newline}"
}

initialize