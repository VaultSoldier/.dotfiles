#!/bin/bash

yay_install() {
        if [[  $(whoami) == "root" ]]; then
               echo "Error: Do not run as root"
	      return 1
        fi      

	if command -v yay &>/dev/null; then
	       echo "yay is already installed"
        	return 0
    	fi

	# remove lefovers if any
	rm -rf /tmp/yay-install-*

	local temp_dir
	temp_dir=$(mktemp -d -t yay-install-XXXXXX) || {
	   echo "Failed to create temporary directory" >&2
	   return 1
	}
 
	cleanup() {
		[[ -d "$temp_dir" ]] && rm -rf "$temp_dir"
	}
	trap cleanup EXIT ERR

   	if ! sudo pacman -Sy --noconfirm --needed base-devel git; then
   	   echo "Failed to install dependencies" >&2
   	   return 1
   	fi

	if ! git clone https://aur.archlinux.org/yay.git "$temp_dir"; then
	   rm -rf 'temp_dir'
	   echo "Failed to clone yay repository" >&2
	   return 1
	fi

   	cd "$temp_dir" || {
   	   echo "Failed to enter build directory" >&2
   	   return 1
   	}
    
   	if ! makepkg -si --noconfirm; then
   	   echo "Failed to build/install yay" >&2
   	   return 1
   	fi

	echo 'yay installed'
}
