#!/bin/sh

[[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

hsetroot -solid "#3B4252"

setxkbmap -layout se

exec i3
