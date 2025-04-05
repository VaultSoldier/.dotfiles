              _/_/_/      _/_/    _/_/_/_/_/  _/_/_/_/  _/_/_/  _/        _/_/_/_/    _/_/_/  
             _/    _/  _/    _/      _/      _/          _/    _/        _/        _/         
            _/    _/  _/    _/      _/      _/_/_/      _/    _/        _/_/_/      _/_/      
           _/    _/  _/    _/      _/      _/          _/    _/        _/              _/     
          _/_/_/      _/_/        _/      _/        _/_/_/  _/_/_/_/  _/_/_/_/  _/_/_/        

## Requirements

### Oh-My-Posh

[Installation guide](https://ohmyposh.dev/docs/installation/linux)

### Git

```sh
pacman -S git 
apt-get install git
```

### GNU stow

```sh
pacman -S stow
apt-get install stow
```

### Zoxide, fzf

```sh
pacman -S zoxide fzf
apt-get install zoxide fzf
```

## Installation

Clone
```sh
git clone https://github.com/VaultSoldier/dotfiles.git
```

Backup .bashrc/.zshrc
```sh
mv ~/.bashrc ~/.bashrc.bak
mv ~/.zshrc ~/.zshrc.bak
```

Use GNU stow to create symlinks
```sh
cd ~/.dotfiles
stow --no-folding .
```

*Optional<sup>TM</sup>*<br>
Install packages
```sh
sudo ~/.dotfiles/scripts/install.sh
```
