#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

xsetroot -solid "#0E1116"

setxkbmap -layout se

exec i3
