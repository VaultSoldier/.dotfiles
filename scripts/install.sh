#!/bin/bash
while
	echo "[1]Full Install | [2]Minimal install | [3]Remove | [4]Exit" && read choice
	[[ -z $choice || $choice != [1-4] ]] && echo "Incorrect input"
do true; done

packages='stow wl-clipboard neovim tmux htop btop tealdeer man-db zoxide fzf ncdu ripgrep kitty flatpak'
minimalPackages='stow neovim ripgrep fzf'
arch_pkgs='github-cli git-zsh-completion'
debian_pkgs='gh'

fullInstall() {
	while 
		read -p "Install tailscale? [Y/n]: " tailscaleInstall
		[[ -z $tailscaleInstall || ! $tailscaleInstall =~ ^[yYnN]$ ]]  
	do true; done
	[[ "$tailscaleInstall" == "Y" || "$tailscaleInstall" == "y" ]] && curl -fsSL https://tailscale.com/install.sh | sh
	[ -f /etc/arch-release ] && pacman -Sy --needed $packages $arch
	[ -f /etc/debian_version ] && apt-get update && apt-get install $packages $debian_pkgs && 
    flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
	systemSupport
}

install() {
	[ -f /etc/arch-release ] && pacman -Sy --needed $minimalPackages
	[ -f /etc/debian_version ] && apt-get update && apt-get install $minimalPackages
	systemSupport
}

remove() {
	[ -f /etc/arch-release ] && pacman -Rns $packages $arch_pkgs
	[ -f /etc/debian_version ] && apt-get purge $packages $debian_pkgs && apt-get autoremove
	systemSupport
}

systemSupport() {
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
	esac
