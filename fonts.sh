#!/usr/bin/env bash

copy_fonts() {
    src="$1"
    dest="$2"
    work_dir="$PWD/$src"

    if [[ ! -d "$dest" ]]; then
        printf 'Directory "%s" does not exist.\n' "$dest"
        printf 'Creating directory "%s"...\n' "$dest"
        sudo mkdir -p "$dest"
    fi

    pushd "$work_dir" > /dev/null || printf 'Cannot push to dir "%s"\n' "$work_dir" && exit 1

    for font_dir in *; do
        if [[ -d $font_dir ]]; then
            printf 'Copying "%s" from "%s" to "%s"...\n' "$font_dir" "$work_dir" "$dest"
            sudo cp -r "$font_dir" "$dest/"
        fi
    done

    cd "$(dirs -l -0)" && dirs -c
}

setup_fonts() {
    printf "Setting up fonts...\n"

    base_dir="fonts"
    global_dest="/usr/share/fonts"
    local_dest="$HOME/.local/share/fonts"

    copy_fonts "$base_dir" "$global_dest"
    copy_fonts "$base_dir" "$local_dest"

    printf '%s\n' "Done."
}

setup_fonts
