#!/bin/bash

copy_fonts() {
	src="${1}"
	dest="${2}"
	workdir="$PWD/${src}"

	if [[ ! -d "${dest}" ]]; then
		echo -e "\nDirectory ${dest} does not exist."
		echo -e "\nCreating it...\n"
		sudo mkdir -pv "${dest}"
	fi

	pushd "${workdir}" > /dev/null

	for FONT_DIR in *; do
		if [[ -d ${FONT_DIR} ]]; then
			echo -e "\nCopying ${FONT_DIR} from ${workdir} to ${dest} ...\n"
			sudo cp -rv "${FONT_DIR}" "${dest}/"
		fi
	done

	cd "$(dirs -l -0)" && dirs -c
}

setup_fonts() {
	echo -e "\nSetting up fonts..."

	base_dir="fonts"
	global_dest="/usr/share/fonts"
	local_dest="${HOME}/.local/share/fonts"

	copy_fonts ${base_dir} ${global_dest}
	copy_fonts ${base_dir} ${local_dest}

	echo -e "\nDONE.\n"
}

setup_fonts
