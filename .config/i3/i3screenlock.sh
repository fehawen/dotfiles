#!/bin/bash

# TODO Fix image resolutions/scale

declare "screen_resolution=$(xrandr | grep \* | awk '{print $1}')"

if [[ "$screen_resolution" == "3200x1800" ]]; then
	i3lock -i ~/.wallpapers/wallpaper-3200x1800.png
elif [[ "$screen_resolution" == "3440x1440" ]]; then
	exec --no-startup-id i3lock -i ~/.wallpapers/wallpaper-3440x1440.png
elif [[ "$screen_resolution" == "1920x1080" ]]; then
	exec --no-startup-id i3lock -i ~/.wallpapers/wallpaper-1920x1080.png
else
	exec --no-startup-id i3lock -c "#0D202F"
fi

