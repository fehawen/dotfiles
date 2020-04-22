#!/usr/bin/env bash

PROGNAME=$(basename "$0")

exit_on_fail() {
    "$@" 2> /dev/null
    code=$?
    if [[ $code -ne 0 ]]; then
      printf 'err: command [%s] failed with error code %s\nfile: %s\nline: %s\n' \
          "$*" \
          "$code" \
          "$PROGNAME" \
          "$LINENO" 1>&2
    fi
}

symlink_tilde_files() {
    tildes=(
        ".asoundrc"
        ".bash_profile"
        ".bashrc"
        ".hushlogin"
        ".inputrc"
        ".profile"
        ".vimrc"
        ".xinitrc"
        ".Xresources"
    )

    exit_on_fail pushd "$PWD/tilde"

    for FILE in "${tildes[@]}"; do
        exit_on_fail ln -sfv "$PWD/$FILE" "$HOME/$FILE"
    done

    cd "$(dirs -l -0)" && dirs -c
}

symlink_files() {
    exit_on_fail pushd "$PWD/$1"

    for FILE in *; do
        if [ -f "$FILE" ]; then
            exit_on_fail ln -sfv "$PWD/$FILE" "$HOME/$1/$FILE"
        fi
    done

    cd "$(dirs -l -0)" && dirs -c
}

setup_dotfiles() {
    echo "Setting up Arch Linux config ..."

    folders=(
        ".colors"
        ".config/fontconfig"
        ".config/nvim"
        ".newsboat"
        "tilde"
    )

    shopt -s dotglob

    for folder in "${folders[@]}"; do
        echo -e "\nSymlinking files in $folder ..."

        if [[ "$folder" == "tilde" ]]; then
            symlink_tilde_files
        else
            if [[ ! -d "$HOME/$folder" ]]; then
              echo -e "\nDirectory $folder does not exist."
              echo -e "\nCreating it..."
              exit_on_fail mkdir -pv "$HOME/$folder"
            fi

            symlink_files "$folder"
        fi
    done

    shopt -u dotglob

    printf 'DONE.\n'
}

setup_dotfiles
