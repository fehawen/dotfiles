#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 133

xsetroot -solid "#3D4C5F"

setxkbmap se

exec i3
