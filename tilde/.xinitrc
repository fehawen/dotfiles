#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

xrandr --dpi 220

setxkbmap se

exec i3
