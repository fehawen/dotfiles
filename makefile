.SILENT:

setup:
	cd scripts && ./pre_setup.sh
	cd tilde && ./setup.sh
	cd .config && ./setup.sh
	cd vs_code && ./setup.sh
