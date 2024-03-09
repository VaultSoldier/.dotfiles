# Dotfiles

## Requirements

### Git

```
pacman -S git 
apt-get install git
```

### GNU stow
```
pacman -S stow
apt-get install stow

## Installation 

Clone and run install script

```
git clone https://github.com/VaultSoldier/dotfiles.git
sudo ~/.dotfiles/scripts/install.sh
```

Use GNU stow to create symlinks

```
cd ~/.dotfiles
stow .
```
