#!/usr/bin/env bash

PROGNAME=$(basename "$0")

exit_on_fail() {
  "$@" 2> /dev/null
  code=$?
  if [[ ${code} -ne 0 ]]; then
    echo -e "\nERROR: Command [$*] failed with error code ${code}\nFILE: ${PROGNAME}\nLINE: $LINENO\n" 1>&2
  fi
}

symlink_tilde_files() {
  tildes=(
    ".bash_profile"
    ".bashrc"
    ".hushlogin"
    ".inputrc"
    ".profile"
    ".xinitrc"
    ".Xresources"
  )

  exit_on_fail pushd "$PWD/tilde"

  for FILE in "${tildes[@]}"; do
    exit_on_fail ln -sfv "$PWD/$FILE" "${HOME}/$FILE"
  done

  cd "$(dirs -l -0)" && dirs -c
}

symlink_hardware_specific_tilde_files() {
  exit_on_fail pushd "$PWD/tilde/${1}"

  for FILE in *; do
    if [[ -f "$FILE" ]]; then
      exit_on_fail ln -sfv "$PWD/$FILE" "${HOME}/$FILE"
    fi
  done

  cd "$(dirs -l -0)" && dirs -c
}

confirm_hardware() {
  echo -e "\nHardware specific configuration...\n"

  PS3="Please select your computer model: "

  declare -a options=(
    "Dell XPS 13 9343"
    "HP ProBook 650 G3"
    "Quit"
  )

  select OPT in "${options[@]}"
  do
    case $OPT in
      "Dell XPS 13 9343")
        symlink_hardware_specific_tilde_files "xps"
        break
        ;;
      "HP ProBook 650 G3")
        symlink_hardware_specific_tilde_files "probook"
        break
        ;;
      "Quit")
        break
        ;;
      *) echo -e "\nInvalid option: $REPLY\n";;
    esac
  done
}

symlink_files() {
  exit_on_fail pushd "$PWD/$1"

  for FILE in *; do
    if [ -f "$FILE" ]; then
      exit_on_fail ln -sfv "$PWD/$FILE" "${HOME}/$1/$FILE"
    fi
  done

  cd "$(dirs -l -0)" && dirs -c
}

setup_dotfiles() {
  echo "Setting up Arch Linux config ..."

  folders=(
    ".colors"
    ".config/dunst"
    ".config/fontconfig"
    ".config/kitty"
    ".config/neofetch"
    ".config/nvim"
    ".config/nvim/colors"
    ".config/nvim/plugin"
    ".config/ranger"
    ".newsboat"
    "tilde"
  )

  shopt -s dotglob

  for FOLDER in "${folders[@]}"; do
    echo -e "\nSymlinking files in $FOLDER ..."

    if [[ "$FOLDER" == "tilde" ]]; then
      symlink_tilde_files
    else
      if [[ ! -d "${HOME}/$FOLDER" ]]; then
        echo -e "\nDirectory $FOLDER does not exist."
        echo -e "\nCreating it..."
        exit_on_fail mkdir -pv "${HOME}/$FOLDER"
      fi

      symlink_files "$FOLDER"
    fi
  done

  confirm_hardware
  shopt -u dotglob

  echo -e "DONE.\n"
}

setup_dotfiles
