#!/usr/bin/env bash

INTERNAL_OUTPUT="$(xrandr | grep "primary" | awk '{print $1}')"
EXTERNAL_OUTPUT_1="$(xrandr | grep -w "connected" | awk '{if(NR>1)print $1}' | head -1)"
EXTERNAL_OUTPUT_2="$(xrandr | grep -w "connected" | awk '{if(NR>2)print $1}')"

if [[ -n ${EXTERNAL_OUTPUT_1} ]] && [[ -n ${EXTERNAL_OUTPUT_2} ]]; then

	xrandr \
		--output "$INTERNAL_OUTPUT" --off \
		--output "$EXTERNAL_OUTPUT_1" --auto \
		--output "$EXTERNAL_OUTPUT_2" --auto --right-of "$EXTERNAL_OUTPUT_1"

elif [[ -n ${EXTERNAL_OUTPUT_1} ]] && [[ -z ${EXTERNAL_OUTPUT_2} ]]; then

	xrandr \
		--output "$INTERNAL_OUTPUT" --off \
		--output "$EXTERNAL_OUTPUT_1" --auto

else

	xrandr --auto

fi

i3-msg "restart"
