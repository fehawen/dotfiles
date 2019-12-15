#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

feh --bg-fill ~/.wallpapers/mist.jpg

setxkbmap -layout se

exec i3
