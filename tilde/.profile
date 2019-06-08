if [[ "$OSTYPE" =~ "darwin" ]]; then
	export EDITOR="/usr/local/bin/nvim"
else
	export EDITOR="usr/bin/nvim"
	export BROWSER="usr/bin/palemoon"
fi
