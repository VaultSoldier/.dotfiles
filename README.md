              _/_/_/      _/_/    _/_/_/_/_/  _/_/_/_/  _/_/_/  _/        _/_/_/_/    _/_/_/  
             _/    _/  _/    _/      _/      _/          _/    _/        _/        _/         
            _/    _/  _/    _/      _/      _/_/_/      _/    _/        _/_/_/      _/_/      
           _/    _/  _/    _/      _/      _/          _/    _/        _/              _/     
          _/_/_/      _/_/        _/      _/        _/_/_/  _/_/_/_/  _/_/_/_/  _/_/_/        

### Requirements

[Oh-My-Posh](https://ohmyposh.dev/docs/installation/linux), zoxide, fzf

### Installation

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
stow .
```

*Optional*<br>
Install packages
```sh
sudo ~/.dotfiles/scripts/install.sh
```
