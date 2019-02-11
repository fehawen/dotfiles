all: bash-setup chunkwm-setup hyper-setup neovim-setup vscode-setup

bash-setup:
	cd bash_prompt && ./setup.sh

chunkwm-setup:
	cd chunkwm && ./setup.sh

hyper-setup:
	cd hyper_terminal && ./setup.sh

neovim-setup:
	cd neovim && ./setup.sh

vscode-setup:
	cd vs_code && ./setup.sh