#!/bin/sh
[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources &

xrandr --dpi 130

setxkbmap se

exec i3
