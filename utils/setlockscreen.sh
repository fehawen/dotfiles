#!/bin/bash

# TODO Fix image resolutions/scale

screen_resolution=$(xrandr | grep \* | awk '{print $1}')

#if [[ "$screen_resolution" == "3200x1800" ]]; then
#	i3-msg 'exec --no-startup-id i3lock -i ~/Dotfiles/.wallpapers/wallpaper.png' &> /dev/null
#elif [[ "$screen_resolution" == "3440x1440" ]]; then
#	i3-msg 'exec --no-startup-id i3lock -i ~/Dotfiles/.wallpapers/wallpaper-3440x1440.png' &> /dev/null
#elif [[ "$screen_resolution" == "1920x1080" ]]; then
#	i3-msg 'exec --no-startup-id i3lock -i ~/Dotfiles/.wallpapers/wallpaper-1920x1080.png' &> /dev/null
#else
#	i3-msg 'exec --no-startup-id i3lock -c "#182226"' &> /dev/null
#fi

i3-msg 'exec --no-startup-id i3lock -c "#182226"' &> /dev/null

