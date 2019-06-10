#!/usr/bin/env bash

setup_prompt() {
	themes=(
		"recursive.sh"
		"captain.sh"
		"industrial.sh"
	)

	read -r -p "Include BASH PROMPT themes? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Excluding BASH PROMPT themes."
		echo "Proceeding."
	else
		echo "Setting up BASH PROMPT themes."

		for inc in ${themes[@]}
		do
			ln -sfv "$PWD/prompt/$inc" "$HOME/.config/prompt/" || error "Failed to symlink $1"
		done
	fi

	echo "Done."
}


setup_neofetch() {
	read -r -p "Include NEOFETCH? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Excluding NEOFETCH."
		echo "Proceeding."
	else
		echo "Setting up NEOFETCH."
		echo "Checking if neofetch exists."

		# Look (desperately) for existing NeoFetch installation, else install it
		if [[ ! $(which neofetch 2> /dev/null) ]] && [[ ! $(brew ls --versions neofetch 2> /dev/null) ]] && [[ ! $(pacman -Q neofetch 2> /dev/null) ]]; then
			echo "Couldn't find existing NEOFETCH installation."
			echo "Now installing."

			# If not macOS, presume we're using Arch
			if [[ "$OSTYPE" =~ "darwin" ]]; then
				echo "Now installing NEOFETCH for macOS."
				brew install neofetch
			else
				echo "Now installing NEOFETCH for Arch."
				sudo pacman -S neofetch
			fi

		else
			echo "Existing NEOFETCH installation found."
			echo "Proceeding."
		fi

		ln -sfv "$PWD/neofetch/config.conf" "$HOME/.config/neofetch/" || error "Failed to symlink $1"
	fi

	echo "Done."
}

setup_neovim() {
	read -r -p "Include NEOVIM? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Excluding NEOVIM."
		echo "Proceeding."
	else
		echo "Setting up NEOVIM."
		echo "Checking if NEOVIM exists."

		# Look (desperately) for existing NeoVim installation, else install it
		if [[ ! $(which nvim 2> /dev/null) ]] && [[ ! $(brew ls --versions neovim 2> /dev/null) ]] && [[ ! $(pacman -Q neovim 2> /dev/null) ]]; then
			echo "Couldn't find existing NEOVIM installation."

			# If not macOS, presume we're using Arch
			if [[ "$OSTYPE" =~ "darwin" ]]; then
				echo "Now installing NEOVIM for macOS."
				brew install neovim
			else
				echo "Now installing NEOVIM for Arch."
				sudo pacman -S neovim
			fi

		else
			echo "Existing NEOVIM installation found."
			echo "Proceeding."
		fi

		ln -sfv "$PWD/nvim/init.vim" "$HOME/.config/nvim/" || error "Failed to symlink '$PWD/nvim/init.vim'"

		ln -sfv "$PWD/nvim/colors/recursive.vim" "$HOME/.config/nvim/colors/" || error "Failed to symlink '$PWD/nvim/colors/recursive.vim'"

		ln -sfv "$PWD/nvim/colors/industrial.vim" "$HOME/.config/nvim/colors/" || error "Failed to symlink '$PWD/nvim/colors/industrial.vim'"

		ln -sfv "$PWD/nvim/plugin/statusline.vim" "$HOME/.config/nvim/plugin/" || error "Failed to symlink '$PWD/nvim/plugin/statusline.vim'"
	fi

	echo "Done."
}

setup_prompt
setup_kitty
setup_neofetch
setup_neovim
