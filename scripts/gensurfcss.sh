#!/bin/bash

# Generates suckless surf style file

PROGNAME=$(basename "$0")

exit_on_fail() {
	"$@" 2> /dev/null
	local code=$?
	if [[ ${code} -ne 0 ]]; then
		echo -e "\nERROR: Command [$*] failed with error code ${code}\nFILE: ${PROGNAME}\nLINE: $LINENO\n" 1>&2
	fi
}

DEST_DIR="${HOME}/.surf/styles"
DEST_FILE="default.css"

if [ ! -d "${DEST_DIR}" ]; then
	exit_on_fail mkdir -pv "${DEST_DIR}"
fi

get_xres() {
	exit_on_fail xrdb -query | grep "$1" | awk '{print $2}'
}

get_xfont() {
	exit_on_fail xrdb -query | grep "font" | cut -d: -f3
}

# set completion-bg "$(get_xres background:)"
OUTPUT="$(cat << CONF
* {
	font-family: "$(get_xfont)" !important;
	background-color: $(get_xres background:) !important;
	color: $(get_xres foreground:) !important;
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
	background-color: $(get_xres background:) !important;
	color: $(get_xres foreground:) !important;
}

div {
	font-family: "$(get_xfont)" !important;
	background-color: $(get_xres background:) !important;
	color: $(get_xres foreground:) !important;
}

h1 {
	font-family: "$(get_xfont)" !important;
	background-color: $(get_xres background:) !important;
	color: $(get_xres foreground:) !important;
}

a h1 {
	font-family: "$(get_xfont)" !important;
	color: $(get_xres blue:) !important;
}

h2,
h3,
h4,
h5,
h6 {
	font-family: "$(get_xfont)" !important;
	background-color: $(get_xres background:) !important;
	color: $(get_xres foreground:) !important;
}

a h2,
a h3,
a h4,
a h5,
a h6 {
	font-family: "$(get_xfont)" !important;
	color: $(get_xres blue:) !important;
}

a p {
	font-family: "$(get_xfont)" !important;
	color: $(get_xres green:) !important;
}

a {
	font-family: "$(get_xfont)" !important;
	color: $(get_xres magenta:) !important;
	background-color: $(get_xres background:) !important;
	border: none !important;
}

button {
	font-family: "$(get_xfont)" !important;
	background-color: $(get_xres background:) !important;
	color: $(get_xres magenta:) !important;
	border: none !important;
	border-radius: 0 !important;
}

summary {
	font-family: "$(get_xfont)" !important;
	background-color: $(get_xres background:) !important;
	color: $(get_xres foreground:) !important;
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
	background-color: $(get_xres background:) !important;
	color: $(get_xres magenta:) !important;
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
	background-color: $(get_xres background:) !important;
	color: $(get_xres magenta:) !important;
}

a svg {
	fill: $(get_xres magenta:) !important;
}

summary svg {
	fill: $(get_xres magenta:) !important;
}

svg {
	fill: $(get_xres magenta:) !important;
}

hr {
	display: none !important;
}

input, form {
	font-family: "$(get_xfont)" !important;
	background-color: $(get_xres background:) !important;
	color: $(get_xres magenta:) !important;
	border-radius: 0 !important;
}

input {
	font-family: "$(get_xfont)" !important;
	border: 1px solid $(get_xres magenta:) !important;
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
	color: $(get_xres yellow:) !important;
	background: $(get_xres background:) !important;
	border: none !important;
	border-radius: 4px !important;
}

pre span,
code span {
	color: $(get_xres magenta:) !important;
	background: $(get_xres background:) !important;
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
