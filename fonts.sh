#!/bin/sh

f="fonts"
d=~/.fonts

[ -d "$f" ] || {
    printf 'Directory "%s" does not exist.\nExiting ...' "$d"
    exit 1
}

mkdir -pv "$d" || {
    printf 'Failed to create directory "%s".\nExiting ...' "$d"
    exit 1
}

printf 'Copying fonts to "%s" ...\n' "$d"

for font in "$f/"*; do
    cp "$font" "$d/"
done

printf 'Making font dir for "%s" ...\n' "$d"

mkfontdir "$d"

printf 'Updating fc cache ...\n'

fc-cache -f

printf 'Done.\n'
