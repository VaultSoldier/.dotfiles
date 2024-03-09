#!/bin/bash

packages='curl stow wl-clipboard neovim tmux htop tldr man-db zoxide fzf ncdu'

if [[ -f /etc/arch-release ]]; then
	pacman -Sy --needed $packages github-cli
elif [[ -f /etc/debian_version ]]; then
	apt-get update
	apt-get install $packages gh
else
	echo 'Unsuported system'
fi
