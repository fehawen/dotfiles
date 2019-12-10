#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xrandr --dpi 55

# xsetroot -solid "#0D202F"
xsetroot -solid "#3E444A"

setxkbmap -layout se

exec i3
