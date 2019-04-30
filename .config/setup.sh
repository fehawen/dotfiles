#!/bin/bash

setup_kitty() {
	kitty=(
		"ezra.conf"
		"industrial.conf"
		"kitty.conf"
		"xwing.conf"
	)

	read -r -p "Include kitty? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Excluding kitty..."
		echo -e "Proceeding...\n"
	else
		echo -e "\nSetting up kitty..."
		echo "Checking if kitty exists..."

		if [[ ! $(ls /Applications/ | grep -i kitty) ]]; then
			echo -e "\nCouldn't find existing kitty installation."
			echo "Now installing..."
			curl -L https://sw.kovidgoyal.net/kitty/installer.sh | sh /dev/stdin
		else
			echo -e "\nExisting kitty installation found."
			echo "Proceeding..."
		fi

		for inc in ${kitty[@]}
		do
			echo -e "\nSymlinking '$HOME/.config/kitty/$inc'."
			ln -sfv "$(PWD)/kitty/$inc" "$HOME/.config/kitty/" || error "Failed to symlink $1"
		done
	fi

	echo -e "Done.\n"
}

setup_neofetch() {
	read -r -p "Include neofetch? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo -e "\nExcluding neofetch..."
		echo "Proceeding..."
	else
		echo -e "\nSetting up neofetch..."
		echo "Checking if neofetch exists..."

		if [[ ! $(which neofetch) ]] && [[ ! $(brew ls --versions neofetch) ]]; then
			echo -e "\nCouldn't find existing neofetch installation."
			echo "Now installing..."
			brew install neofetch
		else
			echo -e "\nExisting neofetch installation found:"
			echo "Proceeding..."
		fi

		echo -e "\nSymlinking '$HOME/.config/neofetch/config.conf'."
		ln -sfv "$(PWD)/neofetch/config.conf" "$HOME/.config/neofetch/" || error "Failed to symlink $1"
	fi

	echo -e "Done.\n"
}

setup_neovim() {
	read -r -p "Include neovim? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo -e "\nExcluding neovim..."
		echo "Proceeding..."
	else
		echo -e "\nSetting up neovim..."
		echo "Checking if neovim exists..."

		if [[ ! $(which nvim) ]] && [[ ! $(brew ls --versions neovim) ]]; then
			echo -e "\nCouldn't find existing neovim installation."
			echo "Now installing..."
			brew install neovim
		else
			echo -e "\nExisting neovim installation found."
			echo "Proceeding..."
		fi

		echo -e "\nSymlinking '$HOME/.config/nvim/init.vim'."
		ln -sfv "$(PWD)/nvim/init.vim" "$HOME/.config/nvim/" || error "Failed to symlink '$(PWD)/nvim/init.vim'"

		echo -e "\nSymlinking '$HOME/.config/nvim/colors/xwing.vim'."
		ln -sfv "$(PWD)/nvim/colors/xwing.vim" "$HOME/.config/nvim/colors/" || error "Failed to symlink '$(PWD)/nvim/colors/xwing.vim'"

		echo -e "\nSymlinking '$HOME/.config/nvim/colors/industrial.vim'."
		ln -sfv "$(PWD)/nvim/colors/industrial.vim" "$HOME/.config/nvim/colors/" || error "Failed to symlink '$(PWD)/nvim/colors/industrial.vim'"

		echo -e "\nSymlinking '$HOME/.config/nvim/colors/ezra.vim'."
		ln -sfv "$(PWD)/nvim/colors/ezra.vim" "$HOME/.config/nvim/colors/" || error "Failed to symlink '$(PWD)/nvim/colors/ezra.vim'"
	fi

	echo -e "Done.\n"
}

setup_kitty
setup_neofetch
setup_neovim
