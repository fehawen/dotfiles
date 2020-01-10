#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# xrandr --dpi 55

hsetroot -solid "#3B4252"

setxkbmap -layout se

exec i3
