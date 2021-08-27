#!/bin/sh

#
# .xinitrc
#

xset b off
xset m 1/1
xset +fp ~/.fonts
xset r rate 200 60
xrdb ~/.Xresources
xrandr --dpi 192
xsetroot -solid "#babbbd"
setxkbmap -layout se

exec vswm
