#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

xsetroot -solid "#000000"

setxkbmap -layout se

exec i3
