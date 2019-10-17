#!/bin/sh

LASTPAC_SECS=$(date -d $(grep --color=no Running\ \'pacman\ -S\ -y\ -u /var/log/pacman.log | tail -1 | awk '{print $1}' | sed "s/\[//" | awk -F "-" '{print $2,"/",$3,"/",$1}' | sed s/\ //g) +%s)
CURRENT_SECS=$(date +%s)
DIFF_SECS=$((CURRENT_SECS - $LASTPAC_SECS))

printf '%dh:%dm:%ds\n' $(($DIFF_SECS/3600)) $(($DIFF_SECS%3600/60)) $(($DIFF_SECS%60))
