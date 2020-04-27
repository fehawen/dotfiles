#!/usr/bin/env bash

PROGNAME=$(basename "$0")

exit_on_fail() {
    "$@" &> /dev/null
    code=$?
    if [[ $code -ne 0 ]]; then
      printf 'Error: command [%s] failed with error code %s\nfile: %s\nline: %s\n' \
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
        printf 'Symlinking %s -> %s\n' "${HOME/#$HOME/"~"}/$FILE" "${PWD/#$HOME/"~"}/$FILE"
        exit_on_fail ln -sf "$PWD/$FILE" "$HOME/$FILE"
    done

    cd "$(dirs -l -0)" && dirs -c
}

symlink_files() {
    exit_on_fail pushd "$PWD/$1"

    for FILE in *; do
        if [ -f "$FILE" ]; then
            printf 'Symlinking %s -> %s\n' "${HOME/#$HOME/"~"}/$1/$FILE" "${PWD/#$HOME/"~"}/$FILE"
            exit_on_fail ln -sf "$PWD/$FILE" "$HOME/$1/$FILE"
        fi
    done

    cd "$(dirs -l -0)" && dirs -c
}

setup_dotfiles() {
    printf 'Setting up dotfiles...\n'

    folders=(
        ".colors"
        ".config/fontconfig"
        ".config/nvim"
        ".newsboat"
        "tilde"
    )

    shopt -s dotglob

    for folder in "${folders[@]}"; do
        if [[ "$folder" == "tilde" ]]; then
            symlink_tilde_files
        else
            if [[ ! -d "$HOME/$folder" ]]; then
              printf 'Directory "%s" does not exist.' "$folder"
              printf 'Creating dir "%s"' "$folder"
              exit_on_fail mkdir -p "$HOME/$folder"
            fi

            symlink_files "$folder"
        fi
    done

    shopt -u dotglob

    printf 'Done.\n'
}

setup_dotfiles
