{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    extraConfig = ""; # do NOT generate init.vim / init.lua
    extraLuaPackages = ps: [ ps.magick ];
    extraPackages = [
      pkgs.lua5_1
      pkgs.luarocks
      pkgs.imagemagick
      pkgs.stylua
      pkgs.readline
      pkgs.pkg-config
      pkgs.gcc
      pkgs.cargo
      pkgs.ripgrep
      pkgs.fzf
      pkgs.fd
    ];
    withNodeJs = true;
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
