#!/usr/bin/env sh

echo "Checking which SHELL."

if $(echo "$SHELL" | command grep -i '/bin/bash' &> /dev/null); then
	echo "SHELL is already set to $SHELL"
else
	echo "SHELL is set to $SHELL"

	read -r -p "Change SHELL to /bin/bash? [y/N] " answer
	if [ "$answer" != y ] && [ "$answer" != Y ]; then
		echo "Changing SHELL to /bin/bash."
		chsh -s /bin/bash
	else
		echo "SHELL will remain $SHELL"
		echo "NOTE: Change shell to BASH later when needed or preferred."
	fi
fi

echo "Done."
