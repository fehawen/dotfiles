#!/bin/sh

[ -f "$HOME/.Xresources" ] && xrdb -merge "$HOME/.Xresources"

xrandr --dpi 55

feh --bg-fill ~/.wallpapers/wall.jpg

setxkbmap -layout se

picom -b --config "$HOME/.config/picom/picom.conf"
polybar -c "$HOME/.config/polybar/config" top &

exec sowm
