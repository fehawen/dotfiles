#!/bin/sh

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

feh --bg-fill ~/.wallpapers/wall.jpg

setxkbmap -layout se

exec sowm
