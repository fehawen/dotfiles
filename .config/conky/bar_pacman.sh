#!/bin/sh

time_since_update() {
	local last_update=$(grep Running\ \'pacman\ -Syu /var/log/pacman.log | tail -1 | awk '{print $1, $2}' | sed 's/[][]//g')

	local update_timestamp=$(date -d "$last_update" +%s)
	local current_timestap=$(date +%s)

	local difference=$(($current_timestap - $update_timestamp))

	local output=""

	local weeks=$(( $difference / 604800 ))
	local days=$(( $difference / 60 / 60 / 24 ))
	local hours=$(( $difference / 60 / 60 % 24 ))

	(( $weeks > 0 )) && output+="${weeks}w "
	(( $days > 0 )) && output+="${days}d "
	output+="${hours}h"

	echo "${output}"
}

time_since_update
