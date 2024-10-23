#!/bin/bash

yay && echo -e "Pacman/aur updated\n"; flatpak update
plasma-discover-update 2>/dev/null && echo -e "\nDiscover packages updated!"

notify-send "System Updated!" --icon=data-success --app-name="Updates"
