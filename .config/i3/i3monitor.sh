#!/bin/bash

#internal_output="$(xrandr | grep "primary" | awk '{print $1}')"
#external_output="$(xrandr | grep -w "connected" | awk '{if(NR>1)print $1}')"
#
#if [[ -z "$external_output" ]]; then
#	xrandr --auto
#else
#	xrandr --output $internal_output --off --output $external_output --auto
#fi
#
#i3-msg "restart"

echo "This script can make any of the files in this directory private."
echo "Enter the number of the file you want to protect:"

PS3="Your choice: "
QUIT="QUIT THIS PROGRAM - I feel safe now."

select FILENAME in *;
do
  case $FILENAME in
        "$QUIT")
          echo "Exiting."
          break
          ;;
        *)
          echo "You picked $FILENAME ($REPLY)"
          ;;
  esac
done
