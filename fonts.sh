#!/bin/sh

f="fonts"
d=~/.fonts

[ -d "$f" ] || {
    printf '%s\n' "Directory '$f' does not exist."
    exit 1
}

mkdir -pv "$d" || {
    printf '%s\n' "Failed to create directory '$d'."
    exit 1
}

for font in "$f/"*; do
    cp -v "$font" "$d/"
done

printf '\nDone.\n'
