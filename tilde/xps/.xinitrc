#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

feh --bg-fill ~/.wallpapers/mist.png

setxkbmap -layout se

exec i3
