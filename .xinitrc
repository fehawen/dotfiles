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
xsetroot -solid "#172124"
hsetroot -solid "#172124"
setxkbmap -layout se

conky -q -d -c ~/.conky1rc &
conky -q -d -c ~/.conky2rc &
picom --config="$HOME/.picomrc" -b &

exec i3 -c ~/.i3rc
