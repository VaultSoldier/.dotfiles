              _/_/_/      _/_/    _/_/_/_/_/  _/_/_/_/  _/_/_/  _/        _/_/_/_/    _/_/_/  
             _/    _/  _/    _/      _/      _/          _/    _/        _/        _/         
            _/    _/  _/    _/      _/      _/_/_/      _/    _/        _/_/_/      _/_/      
           _/    _/  _/    _/      _/      _/          _/    _/        _/              _/     
          _/_/_/      _/_/        _/      _/        _/_/_/  _/_/_/_/  _/_/_/_/  _/_/_/        

## Config setup

  ```bash
  nix shell nixpkgs#stow
  stow --no-folding . 
  ```

## SOPS-NIX setup

`mkdir -p $HOME/.config/sops/age/`

Write private key

  ```bash
  nix run nixpkgs#ssh-to-age -- \
    -private-key \
    -i $HOME/.ssh/privatekey \
    -o $HOME/.config/sops/age/keys.txt
  ```

Retrieve public key

  ```bash
  nix shell nixpkgs#age
  age-keygen -y $HOME/.config/sops/age/keys.txt
  ```
