#!/bin/bash

declare popup_width=$(($(xrandr --listmonitors | grep \+ | awk '{print $3}' | cut -d/ -f1) / 100 * 75))
declare popup_height=$(($(xrandr --listmonitors | grep \+ | awk '{print $3}' | cut -dx -f2 | cut -d/ -f1) / 100 * 75))


if [[ ! $(i3-msg -t get_tree | grep -o "popup") ]]; then
	i3-msg "exec --no-startup-id termite --name popup"
	sleep 1
	$(test)
else
	i3-msg "[instance=\"popup\"] resize set ${popup_width} ${popup_height}; [instance=\"popup\"] scratchpad show; [instance=\"popup\"] move position center"
fi

test() {
	i3-msg "[instance=\"popup\"] resize set ${popup_width} ${popup_height}; [instance=\"popup\"] scratchpad show; [instance=\"popup\"] move position center"
}
