#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

feh --bg-fill ~/.wallpapers/stairway.jpg

setxkbmap -layout se

exec i3
