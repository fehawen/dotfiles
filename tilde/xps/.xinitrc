#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

xsetroot -solid "#0E1116"

setxkbmap -layout se

exec i3
