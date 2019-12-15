#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

feh --bg-fill ~/.wallpapers/mist.jpg

setxkbmap -layout se

exec i3
