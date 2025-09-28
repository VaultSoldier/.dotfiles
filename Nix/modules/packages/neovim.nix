{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    withNodeJs = true;
  };

  environment.systemPackages = with pkgs; [
    lua5_1
    imagemagick
    readline
    pkg-config
    gcc
    cargo
    ripgrep
    fzf
    fd
  ];

  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };

  programs.nix-ld.enable = true;
  programs.nix-ld.libraries = with pkgs; [ stylua ];
}

