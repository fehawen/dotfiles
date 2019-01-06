#!/bin/bash

red="$(tput setaf 1)"
green="$(tput setaf 2)"
reset="$(tput sgr0)"

initialize() {
	read -r -p "${green}Install bash prompt? ${reset}[y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "${red}Installation declined${reset}"
		exit
	else
		setup_bash_prompt
	fi
}

setup_bash_prompt() {
	echo "${green}Installing Bash prompt...${reset}"

	if [ -f $HOME/.bashrc ]; then
		rm $HOME/.bashrc
	fi

	echo "Symlinking .bashrc..."
	ln -sf "$(pwd)/.bashrc" $HOME

	if [ -f $HOME/.bash_profile ]; then
		rm ~/.bash_profile
	fi

	echo "Sourcing .bashrc in .bash_profile..."
	printf '#!/bin/bash' >> $HOME/.bash_profile
	printf '%s\nsource $HOME/.bashrc' >> $HOME/.bash_profile

	if [ -f $HOME/.hushlogin ]; then
		rm $HOME/.hushlogin
	fi

	echo "Symlinking .hushlogin for muted terminal login message..."
	ln -sf "$(pwd)/.hushlogin" $HOME

	echo "Checking which shell..."
	if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
		echo "Shell is already set to $SHELL"
	else
		echo "Shell is set to $SHELL"
		echo "Changing shell to /bin/bash"
		chsh -s /bin/bash
	fi

	echo "${green}Bash prompt installation complete.${reset}"
	echo "Enter source ~/.bashrc to reload prompt"
	echo "Remember to install a PowerLine Font"
}

initialize