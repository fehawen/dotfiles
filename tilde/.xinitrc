#!/bin/sh

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

setxkbmap -layout se

cpr light

exec sowm
