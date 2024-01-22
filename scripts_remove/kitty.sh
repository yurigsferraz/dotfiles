#!/bin/bash

rm -rf ~/.local/kitty.app
rm -rf ~/.local/share/applications/kitty*.desktop
sudo update-alternatives --auto x-terminal-emulator
