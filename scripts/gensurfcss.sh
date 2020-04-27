#!/usr/bin/env bash

# Generates suckless surf style file

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

# shellcheck disable=SC1090
source "$HOME/.cache/wal/colors.sh"

DEST_DIR="${HOME}/.surf/styles"
DEST_FILE="default.css"

if [ ! -d "${DEST_DIR}" ]; then
  exit_on_fail mkdir -pv "${DEST_DIR}"
fi

get_xfont() {
  exit_on_fail xrdb -query | grep "font" | cut -d: -f3
}

# shellcheck disable=SC2154
OUTPUT="$(cat << CONF
* {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $foreground !important;
  border: none !important;
  border-top: none !important;
  border-right: none !important;
  border-bottom: none !important;
  border-left: none !important;
}

*::before {
  background-image: none !important;
}

pre,
textarea,
body,
td,
tr,
p {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $foreground !important;
}

div {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $foreground !important;
}

h1 {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $foreground !important;
}

a h1 {
  font-family: "$(get_xfont)" !important;
  color: $color4 !important;
}

h2,
h3,
h4,
h5,
h6 {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $foreground !important;
}

a h2,
a h3,
a h4,
a h5,
a h6 {
  font-family: "$(get_xfont)" !important;
  color: $color4 !important;
}

a p {
  font-family: "$(get_xfont)" !important;
  color: $color2 !important;
}

a {
  font-family: "$(get_xfont)" !important;
  color: $color5 !important;
  background-color: $background !important;
  border: none !important;
}

button {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $color5 !important;
  border: none !important;
  border-radius: 0 !important;
}

summary {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $foreground !important;
  border: none !important;
  border-radius: 0 !important;
}

button svg,
button i,
button span,
button div,
button p,
button h1,
button h2,
button h3,
button h4,
button h5,
button h6,
a svg,
a i,
a span,
a div {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $color5 !important;
}

summary svg,
summary i,
summary span,
summary div,
summary p,
summary h1,
summary h2,
summary h3,
summary h4,
summary h5,
summary h6,
button svg {
  background-color: $background !important;
  color: $color5 !important;
}

a svg {
  fill: $color5 !important;
}

summary svg {
  fill: $color5 !important;
}

svg {
  fill: $color5 !important;
}

hr {
  display: none !important;
}

input, form {
  font-family: "$(get_xfont)" !important;
  background-color: $background !important;
  color: $color5 !important;
  border-radius: 0 !important;
}

input {
  font-family: "$(get_xfont)" !important;
  border: 1px solid $color5 !important;
  padding-left: 16px !important;
  padding-right: 16px !important;
  height: 32px !important;
}

label svg {
  display: none !important;
}

form {
  font-family: "$(get_xfont)" !important;
  border: none !important;
}

pre,
code {
  color: $color3 !important;
  background: $background !important;
  border: none !important;
  border-radius: 4px !important;
}

pre span,
code span {
  color: $color5 !important;
  background: $background !important;
}

[class*="cookie"],
[class^="cookie-"],
[class$="-cookie"],
[id*="cookie"],
[id^="cookie-"],
[id$="-cookie"] {
  display: none !important;
  visibility: hidden !important;
}
CONF
)"

printf '%s' "$OUTPUT" > "${DEST_DIR}/${DEST_FILE}"

echo "Generated ${DEST_FILE} in ${DEST_DIR}"
