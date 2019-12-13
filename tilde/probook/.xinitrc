#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

# feh --bg-fill ~/.wallpapers/stairway.jpg
xsetroot -solid "#0D202F"
hsetroot -solid "#0D202F"

setxkbmap -layout se

exec i3
