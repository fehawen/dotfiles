#!/bin/sh

#
# .xinitrc
#

xset b off
xset m 1/1
xset +fp ~/.fonts
xset r rate 200 50
xrdb ~/.Xresources
xrandr --dpi 192
xsetroot -solid "#babbbd"
conky -c ~/.conkyrc -d &
setxkbmap -layout se

exec vswm
