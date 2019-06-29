#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

xrandr --dpi 120

setxkbmap se

exec i3
