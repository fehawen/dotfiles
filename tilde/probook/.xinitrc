#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# xrandr --dpi 55

feh --bg-fill ~/.wallpapers/mist.png

setxkbmap -layout se

exec i3
