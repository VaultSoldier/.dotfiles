#!/bin/sh
echo -e '[1]Full Install | [2]Install deps | [3]Remove'
read choice

packages='stow wl-clipboard neovim tmux htop tldr man-db zoxide fzf ncdu'
minimalPackages='stow neovim'

fullInstall() {
	echo -e 'Install tailscale? [Y/N]'
	read tailscaleInstall
	[ "$tailscaleInstall" == "Y" ] || [ "$tailscaleInstall" == "y" ] && curl -fsSL https://tailscale.com/install.sh | sh
	[ -f /etc/arch-release ] && pacman -Sy --needed $packages github-cli
	[ -f /etc/debian_version ] && apt-get update && apt-get install $packages gh
	[ ! -f /etc/arch-release ] && [ ! -f /etc/debian_version ] && echo 'Unsuported system'
}

install() {
	[ -f /etc/arch-release ] && pacman -Sy --needed $minimalPackages
	[ -f /etc/debian_version ] && apt-get update && apt-get install $minimalPackages
	[ ! -f /etc/arch-release ] && [ ! -f /etc/debian_version ] && echo 'Unsuported system'
}

remove() {
	[ -f /etc/arch-release ] && pacman -Rns $packages github-cli
	[ -f /etc/debian_version ] && apt-get purge $packages gh && apt-get autoremove
	[ ! -f /etc/arch-release ] && [ ! -f /etc/debian_version ] && echo 'Unsuported system'
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
