#!/bin/sh

time_since_update() {
	local last_update=$(grep Running\ \'pacman\ -Syu /var/log/pacman.log | tail -1 | awk '{print $1, $2}' | sed 's/[][]//g')

	local update_timestamp=$(date -d "${last_update}" +%s)
	local current_timestap=$(date +%s)

	local difference=$((${current_timestap} - ${update_timestamp}))

	local output=""

	local duration=$(( ${difference} / 86400 ))

	(( ${duration} == 1 )) && output="${duration} day" || output="${duration} days"

	echo "${output}"
}

time_since_update
