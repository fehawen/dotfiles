#!/bin/bash

declare internal_output="$(xrandr | grep "primary" | awk '{print $1}')"
declare external_output="$(xrandr | grep -w "connected" | awk '{if(NR>1)print $1}')"

if [[ -z "$external_output" ]]; then
	xrandr --auto
else
	xrandr --output $internal_output --off --output $external_output --auto
fi

i3-msg "restart"
