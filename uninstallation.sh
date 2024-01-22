#!/bin/bash
#sudo apt remove -y git zsh resolvconf httpie helm curl ansible fd-find flatpak git-gui libreoffice-calc libreoffice-writer mysql-server python3-pip unzip vim wget whiptail

export DOT_FILES_DIR="$(dirname "$(readlink -f "$0")")"

scripts=(
	kitty
)

for script in "${scripts[@]}";do
    . $DOT_FILES_DIR/scripts_uninstall/$script.sh
done
