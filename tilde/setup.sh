#!/bin/bash

symlink() {
	echo -e "\nSymlinking '$HOME/$1'"
	ln -sfv "$(PWD)/$1" "$HOME/$1" || error "Failed to symlink $1"
}

declare -a includes=(
	.chunkwmrc
	.ctags
	.bashrc
	.bash_profile
	.hushlogin
	.skhdrc
)

initialize() {
	read -r -p "Include tilde config files? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Excluding tilde files..."
		echo -e "Proceeding...\n"
		exit
	else
		setup
	fi
}

setup() {
	echo -e "\nSetting up tilde files..."

	echo -e "\nChecking if chunkwm exists..."

	if [[ ! $(which chunkwm) ]] && [[ ! $(brew ls --versions chunkwm) ]]; then
		echo "Couldn't find existing chunkwm installation."
		echo "Now installing..."
		brew install chunkwm
	else
		echo "Existing chunkwm installation found."
		echo "Proceeding..."
	fi

	echo -e "\nChecking if skhd exists..."

	if [[ ! $(which skhd) ]] && [[ ! $(brew ls --versions skhd) ]]; then
		echo "Couldn't find existing skhd installation."
		echo "Now installing..."
		brew install skhd
	else
		echo "Existing skhd installation found."
		echo "Proceeding..."
	fi

	echo -e "\nChecking which shell..."

	if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
		echo "Shell is already set to $SHELL"
	else
		echo "Shell is set to $SHELL"
		echo "Changing shell to /bin/bash"
		chsh -s /bin/bash
	fi

	for inc in "${includes[@]}"
	do
		symlink "$inc"
	done

	echo -e "Prompt themes will be setup in the next step.\n"
	echo -e "Done.\n"
}

initialize
