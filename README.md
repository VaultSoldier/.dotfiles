               _/_/_/      _/_/    _/_/_/_/_/  _/_/_/_/  _/_/_/  _/        _/_/_/_/    _/_/_/  
              _/    _/  _/    _/      _/      _/          _/    _/        _/        _/         
             _/    _/  _/    _/      _/      _/_/_/      _/    _/        _/_/_/      _/_/      
            _/    _/  _/    _/      _/      _/          _/    _/        _/              _/     
           _/_/_/      _/_/        _/      _/        _/_/_/  _/_/_/_/  _/_/_/_/  _/_/_/        
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

### Zoxide, fzf and oh-my-posh
```
pacman -S zoxide fzf
apt-get install zoxide fzf
https://ohmyposh.dev/docs/installation/linux
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
