#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

feh --bg-fill ~/.wallpapers/wall.jpg

setxkbmap -layout se

exec sowm
