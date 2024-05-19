#!/bin/bash

yay && echo -e "Pacman/aur updated\n"; flatpak update
plasma-discover-update 2>/dev/null && echo -e "\nDiscover packages updated!"
echo Packages updated > /dev/pts/1
