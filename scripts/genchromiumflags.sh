#!/bin/bash

PROGNAME=$(basename "$0")

exit_on_fail() {
	"$@" 2> /dev/null
	local code=$?
	if [[ ${code} -ne 0 ]]; then
		echo -e "\nERROR: Command [$*] failed with error code ${code}\nFILE: ${PROGNAME}\nLINE: $LINENO\n" 1>&2
	fi
}

# Generate chromium-flags for scaling

DEST_DIR="${HOME}/.config"
DEST_FILE="chromium-flags.conf"

if [ ! -d "${DEST_DIR}" ]; then
	echo -e "\nERROR: No ${DEST_DIR} directory found.\nExiting...\n"
	exit 1
fi

OUTPUT=""

PS3="Please select your computer model: "

declare -a options=(
	"Dell XPS 13 9343"
	"HP ProBook 650 G3"
	"Quit"
)

select OPT in "${options[@]}"
do
	case $OPT in
		"Dell XPS 13 9343")
			OUTPUT="--force-device-scale-factor=1.30"
			break
			;;
		"HP ProBook 650 G3")
			OUTPUT="--force-device-scale-factor=0.70"
			break
			;;
		"Quit")
			break
			;;
		*) echo -e "\nInvalid option: $REPLY\n";;
	esac
done

printf '%s' "$OUTPUT" > "${DEST_DIR}/${DEST_FILE}"

echo "Generated ${DEST_FILE} in ${DEST_DIR}"
