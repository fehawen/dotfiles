#!/usr/bin/env bash

copy_fonts() {
    src="$1"
    dest="$2"
    work_dir="$PWD/$src"

    if [[ ! -d "$dest" ]]; then
        printf '%s\n%s\n' "Directory $dest does not exist." "Creating it..."
        sudo mkdir -pv "$dest"
    fi

    pushd "$work_dir" > /dev/null || echo "Cannot push to dir $work_dir" && exit 1

    for font_dir in *; do
        if [[ -d $font_dir ]]; then
            printf '%s\n' "Copying $font_dir from $work_dir to $dest ..."
            sudo cp -rv "$font_dir" "$dest/"
        fi
    done

    cd "$(dirs -l -0)" && dirs -c
}

setup_fonts() {
    printf '%s\n' "Setting up fonts..."

    base_dir="fonts"
    global_dest="/usr/share/fonts"
    local_dest="$HOME/.local/share/fonts"

    copy_fonts "$base_dir" "$global_dest"
    copy_fonts "$base_dir" "$local_dest"

    printf '%s\n' "Done."
}

setup_fonts
