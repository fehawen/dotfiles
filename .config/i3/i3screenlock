#!/bin/bash

# TODO Fix image resolutions/scale

screen_resolution=$(xrandr | grep \* | awk '{print $1}')

if [[ "$screen_resolution" == "3200x1800" ]]; then
	i3-msg 'exec --no-startup-id i3lock -i ~/.wallpapers/wallpaper-3200x1800.png' &> /dev/null
elif [[ "$screen_resolution" == "3440x1440" ]]; then
	i3-msg 'exec --no-startup-id i3lock -i ~/.wallpapers/wallpaper-3440x1440.png' &> /dev/null
elif [[ "$screen_resolution" == "1920x1080" ]]; then
	i3-msg 'exec --no-startup-id i3lock -i ~/.wallpapers/wallpaper-1920x1080.png' &> /dev/null
else
	i3-msg 'exec --no-startup-id i3lock -c "#0D202F"' &> /dev/null
fi

