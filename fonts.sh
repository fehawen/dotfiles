#!/bin/bash

copy_fonts() {
	declare src="${1}"
	declare dest="${2}"

	if [[ ! -d "${dest}" ]]; then
		echo -e "\nDirectory ${dest} does not exist."
		echo -e "\nCreating it...\n"
		sudo mkdir -pv "${dest}"
	fi

	pushd "$PWD/${src}" > /dev/null

	for FONT_DIR in *; do
		if [[ -d ${FONT_DIR} ]]; then
			echo -e "\nCopying ${FONT_DIR} from ${src} to ${dest}...\n"
			sudo cp -rv "${FONT_DIR}" "${dest}/"
		fi
	done

	cd "$(dirs -l -0)" && dirs -c
}

setup_fonts() {
	echo -e "\nSetting up fonts..."

	declare base_dir="fonts"
	declare global_dest="/usr/share/fonts"
	declare local_dest="${HOME}/.local/share/fonts"

	copy_fonts ${base_dir} ${global_dest}
	copy_fonts ${base_dir} ${local_dest}

	echo -e "\nDONE.\n"
}

setup_fonts
