#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

xsetroot -solid "#0D202F"

setxkbmap -layout se

exec i3
