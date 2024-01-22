#!/bin/bash
#sudo apt install -y git zsh resolvconf httpie helm curl ansible

export DOT_FILES_DIR="$(dirname "$(readlink -f "$0")")"

scripts=(
	kitty
)

for script in "${scripts[@]}"; do
    . $DOT_FILES_DIR/scripts_install/$script.sh
done
