#!/bin/bash

INTERNAL_OUTPUT="eDP1"
EXTERNAL_OUTPUT="DP1"

if [[ $(xrandr | grep "$EXTERNAL_OUTPUT disconnected") ]]; then
	xrandr --output $INTERNAL_OUTPUT --auto --output $EXTERNAL_OUTPUT --off
else
	xrandr --output $INTERNAL_OUTPUT --off --output $EXTERNAL_OUTPUT --auto
fi
