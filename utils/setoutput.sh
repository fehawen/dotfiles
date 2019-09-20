#!/bin/bash

EXTERNAL_OUTPUT="DP1"
INTERNAL_OUTPUT="eDP1"

# xrandr | grep \ connected | awk '{print $1}' | grep \e

# xrandr | grep -e " connected [^(]" | sed -e "s/\([A-Z0-9]\+\) connected.*/\1/"

xrandr | grep -w $EXTERNAL_OUTPUT | grep \ connected

if [ $? -eq 0 ]; then
	xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
else
	xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
fi
