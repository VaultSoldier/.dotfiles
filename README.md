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
```

### Zoxide and fzf
Install zoxide for a better cd command or remove `eval "$(zoxide init --cmd cd bash)"` line from .bashrc
```
pacman -S zoxide fzf
apt-get install zoxide fzf
```
## Installation 

Clone
```
git clone https://github.com/VaultSoldier/dotfiles.git
```

Backup .bashrc
```
mv ~/.bashrc ~/.bashrc.bak 
```

Use GNU stow to create symlinks
```
cd ~/.dotfiles
stow .
```

*Optional<sup>TM</sup>*<br>
Install packages 
```
sudo ~/.dotfiles/scripts/install.sh
```
