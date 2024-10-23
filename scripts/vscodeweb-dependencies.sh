#!/bin/bash

while
	echo '[1]Initial setup | [2]Install | [3]Remove | [4]Exit'
	read choice
	[[ -z $choice || $choice != [1-4] ]] && echo "Incorrect input"
do true; done

progs='dialog whiptail lolcat figlet bc jc tmux gcc g++ build-essential python3 git wget tree man-db tldr htop neovim'

[ "$choice" == '1' ] && sudo apt update && sudo apt -y upgrade && sudo apt install -y $progs && sudo unminimize
[ "$choice" == '2' ] && sudo apt update && sudo apt-get install -y $progs
[ "$choice" == '3' ] && sudo apt-get -y remove $progs && sudo apt-get autoremove
