#!/usr/bin/env bash

# shellcheck disable=SC1090
[[ -f ~/.bashrc ]] && source ~/.bashrc

# Start X
if systemctl -q is-active graphical.target && \
    [[ ! $DISPLAY && $XDG_VTNR -eq 1 && "$(tty)" = "/dev/tty1" ]] && \
    ! pgrep -x sowm >/dev/null; then
    exec startx
fi
