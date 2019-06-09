#!/bin/sh

if [[ "$OSTYPE" =~ "linux" ]]; then
	export EDITOR="usr/bin/nvim"
	export BROWSER="usr/bin/palemoon"
fi
