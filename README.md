               _/_/_/      _/_/    _/_/_/_/_/  _/_/_/_/  _/_/_/  _/        _/_/_/_/    _/_/_/  
              _/    _/  _/    _/      _/      _/          _/    _/        _/        _/         
             _/    _/  _/    _/      _/      _/_/_/      _/    _/        _/_/_/      _/_/      
            _/    _/  _/    _/      _/      _/          _/    _/        _/              _/     
           _/_/_/      _/_/        _/      _/        _/_/_/  _/_/_/_/  _/_/_/_/  _/_/_/        
## Requirements

### Oh-My-Posh
[Installation guide](https://ohmyposh.dev/docs/installation/linux)

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

### Zoxide, fzf
```
pacman -S zoxide fzf
apt-get install zoxide fzf
```

## Installation 

Clone
```
git clone https://github.com/VaultSoldier/dotfiles.git
```

Backup .bashrc/.zshrc
```
mv ~/.bashrc ~/.bashrc.bak
mv ~/.zshrc ~/.zshrc.bak
```

Use GNU stow to create symlinks
```
cd ~/.dotfiles
stow --no-folding .
```

*Optional<sup>TM</sup>*<br>
Install packages 
```
sudo ~/.dotfiles/scripts/install.sh
```
