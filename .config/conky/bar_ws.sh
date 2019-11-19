#!/bin/bash

output=""

while read -r ws; do
	read -r active
		if [[ "$active" == true ]]; then
			output="${output}<span fgcolor='#B2BEBF'> ${ws}  </span>"
		else
			output="${output}<span fgcolor='#41515C'> ${ws}  </span>"
		fi
done < <(i3-msg -t get_workspaces | jshon -a -e name -u -p -e focused -u)

echo ${output}
