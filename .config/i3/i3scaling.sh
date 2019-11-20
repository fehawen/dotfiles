#!/bin/bash

declare -r external_output="$(xrandr | grep -w "connected" | awk '{if(NR>1)print $1}')"

if [[ -z "$external_output" ]]; then
	echo "No external monitors found."
	echo "Exiting..."
	exit 0
fi

declare -r default_width="$(xrandr | grep \* | awk '{print $1}' | cut -dx -f1)"
declare -r default_height="$(xrandr | grep \* | awk '{print $1}' | cut -dx -f2)"

confirm() {
	printf "\nCALCULATED CONFIGURATION:\n${1}\n\n"

	read -r -p "Execute xrandr scaling? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Scaling declined..."
		echo "Now exiting."
		exit
	else
		$1 && i3-msg "restart" &> /dev/null
	fi
}

resolution() {
	if [[ "$1" == "default" ]]; then
		echo "${default_width}x${default_height}"
	else
		# Use scale integer arg to calculate resolution,
		# since Bash can't handle decimal calculations
		# So we do e.g. 1024 / 10 * 15 to simulate calculating
		# a 1024 px resolution by 1.5 scaling
		declare width="$((${default_width} / 10 * ${1}))"
		declare height="$((${default_height} / 10 * ${1}))"

		echo "${width}x${height}"
	fi
}

scale() {
	if [[ "$1" == "default" ]]; then
		# Restore to default scale
		declare config="xrandr --output ${external_output} --scale 1x1 --panning ${default_width}x${default_height}"
		confirm "${config}"
	else
		# Convert scale integer arg to floating point
		# to allow for xrandr scale to be set,
		# e.g. convert 15 to 1.5 to scale 1.5x1.5
		declare float="$(printf %.1f "${1}e-1")"
		declare scale="${float}x${float}"

		declare panning="$(resolution ${1})"

		declare config="xrandr --output ${external_output} --scale ${scale} --panning $panning"
		confirm "${config}"
	fi
}

# Must match order an desired value of
# corresponding options array index
declare -a actions=(
	"default"
	11
	12
	13
	14
	15
)

declare -a options=(
	"${external_output} at $(resolution "default") (Default)"
	"${external_output} at $(resolution 11)"
	"${external_output} at $(resolution 12)"
	"${external_output} at $(resolution 13)"
	"${external_output} at $(resolution 14)"
	"${external_output} at $(resolution 15)"
	"Quit"
)

# Enforce columnized options
# Number of columns doesn't matter,
# as long as options are not displayed as rows
COLUMNS=12

PS3="Please select an option: "

select OPT in "${options[@]}"
do
	case $OPT in
		"Quit")
			echo "Quitting..."
			break
			;;
		*)
			# Use reply option index to execute with
			# corresponding actions index as argument
			scale ${actions[$(($REPLY - 1))]}
			break
			;;
	esac
done
