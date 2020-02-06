#!/bin/sh

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

xrandr --dpi 55

feh --bg-fill ~/.wallpapers/wall.jpg

setxkbmap -layout se

exec sowm
