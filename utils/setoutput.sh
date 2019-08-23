#!/usr/bin/env sh

EXTERNAL_OUTPUT="DP1"
INTERNAL_OUTPUT="eDP1"

xrandr | grep -w $EXTERNAL_OUTPUT | grep " connected "

if [ $? -eq 0 ]; then
	xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
else
	xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
fi
