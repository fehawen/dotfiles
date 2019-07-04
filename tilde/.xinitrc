#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

xrandr --dpi 133

setxkbmap se

exec i3
