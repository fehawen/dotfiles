#!/bin/bash

screen_width=$(($(xrandr | grep \* | awk '{print $1}' | cut -dx -f1) / 100 * 75))
screen_height=$(($(xrandr | grep \* | awk '{print $1}' | cut -dx -f2) / 100 * 75))

if [[ ! $(i3-msg -t get_tree | grep -o "popup") ]]; then
	i3-msg "exec --no-startup-id kitty --name popup"
	sleep 1
	$(test)
else
	i3-msg "[instance=\"popup\"] resize set ${screen_width} ${screen_height}; [instance=\"popup\"] scratchpad show; [instance=\"popup\"] move position center"
fi

test() {
	i3-msg "[instance=\"popup\"] resize set ${screen_width} ${screen_height}; [instance=\"popup\"] scratchpad show; [instance=\"popup\"] move position center"
}
