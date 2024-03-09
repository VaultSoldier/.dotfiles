#!/bin/bash
echo -e '[1]Full Install | [2]Install deps | [3]Remove'
read choice

packages='stow wl-clipboard neovim tmux htop tldr man-db zoxide fzf ncdu'
minimalPackages='stow neovim'

fullInstall() {
	if [[ -f /etc/arch-release ]]; then
		pacman -Sy --needed $packages github-cli
	elif [[ -f /etc/debian_version ]]; then
		apt-get update
		apt-get install $packages gh
	else
		echo 'Unsuported system'
	fi
}

install() {
	if [[ -f /etc/arch-release ]]; then
		pacman -Sy --needed $minimalPackages
	elif [[ -f /etc/debian_version ]]; then
		apt-get update
		apt-get install $minimalPackages
	else
		echo 'Unsuported system'
	fi
}

remove() {
	if [[ -f /etc/arch-release ]]; then
		pacman -Rns $packages github-cli
	elif [[ -f /etc/debian_version ]]; then
		apt-get purge $packages gh
		apt-get autoremove
	else
		echo 'Unsuported system'
	fi
}

case $choice in
	"1")
		fullInstall
		;;
	"2")
		install
		;;
	"3")
		remove
		;;
	*)
		echo "Incorrect input"
		;;
esac
