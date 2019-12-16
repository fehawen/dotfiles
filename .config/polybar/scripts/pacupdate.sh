#!/bin/sh

last_update=$(grep Running\ \'pacman\ -Syu /var/log/pacman.log | tail -1 | awk '{print $1, $2}' | sed 's/[][]//g' | cut -dT -f1)

update_timestamp=$(date -d "${last_update}" +%s)
current_timestap=$(date +%s)

difference=$((${current_timestap} - ${update_timestamp}))

output=""

duration=$(( ${difference} / 86400 ))

(( ${duration} == 1 )) && output="${duration} day" || output="${duration} days"

echo "${output}"
