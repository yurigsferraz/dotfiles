#!/bin/bash
#sudo apt install -y git zsh resolvconf httpie helm curl ansible

export DOT_FILES_DIR="$(dirname "$(readlink -f "$0")")"

apt=(
	git
	zsh
	resolvconf
	httpie
	helm
	curl
	ansible
)

for app in "${apt[@]}"; do
	if [[ $1 == "--install" ]]; then
		sudo apt install "$app" -y
	elif [[ $1 == "--remove" ]]; then
		sudo apt remove "$app" -y
	fi
done

scripts=(
	kitty
)

for script in "${scripts[@]}"; do
	if [[ $1 == "--install" ]]; then
    		. $DOT_FILES_DIR/scripts_install/$script.sh
	elif [[ $1 == "--remove" ]]; then
    		. $DOT_FILES_DIR/scripts_remove/$script.sh
	fi
done
