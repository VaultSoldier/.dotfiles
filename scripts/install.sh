#!/bin/bash
while
	echo "[1]Full Install | [2]Minimal install | [3]Remove | [4]Exit" && read choice
	[[ -z $choice || $choice != [1-4] ]] && echo "Incorrect input"
do true; done

packages='stow wl-clipboard neovim tmux htop btop tealdeer man-db zoxide fzf ncdu ripgrep kitty flatpak base-devel npm gnupg unzip go'
minimalPackages='stow neovim ripgrep fzf git'
arch_pkgs='github-cli git-zsh-completion pass man-db podman podman-desktop podman-docker podman-compose'
debian_pkgs='gh'

full_install() {
	while 
		read -p "Install tailscale? [Y/n]: " tailscaleInstall
		[[ -z $tailscaleInstall || ! $tailscaleInstall =~ ^[yYnN]$ ]]  
	do true; done
	[[ "$tailscaleInstall" == "Y" || "$tailscaleInstall" == "y" ]] && curl -fsSL https://tailscale.com/install.sh | sh &&
	[ -f /etc/debian_version ] && flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo

	if [ -f /etc/arch-release ]; then
		source ./yay_install_script.sh
		sudo pacman -Syu --needed $packages $arch_pkgs && yay_install 
		rm -rf /tmp/yay-install-*
	fi
	
	[ -f /etc/debian_version ] && sudo apt-get update && apt-get install $packages $debian_pkgs
	system_support
}

install() {
	[ -f /etc/arch-release ] && sudo pacman -Syu --needed $minimalPackages
	[ -f /etc/debian_version ] && sudo apt-get update && apt-get install $minimalPackages
	systemSupport
}

remove() {
	[ -f /etc/arch-release ] && sudo pacman -Rns $packages $arch_pkgs
	[ -f /etc/debian_version ] && sudo apt-get purge $packages $debian_pkgs && apt-get autoremove
	systemSupport
}

system_support() {
	[ ! -f /etc/arch-release ] && [ ! -f /etc/debian_version ] && echo 'Unsuported system'
}


case $choice in
	"1")
		full_install
		;;
	"2")
		install
		;;
	"3")
		remove
		;;
	esac
