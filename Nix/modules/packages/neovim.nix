{ pkgs, ... }:

let
  config = pkgs.neovimUtils.makeNeovimConfig {
    defaultEditor = true;
    withNodeJs = true;
    extraLuaPackages = p: [ p.magick ];
    extraPackages = p: [
      p.imagemagick
      p.lua5_1
      p.luarocks
      p.imagemagick
      p.stylua
      p.readline
      p.pkg-config
      p.gcc
      p.cargo
      p.ripgrep
      p.fzf
      p.fd
    ];
  };
in {
  nixpkgs.overlays = [
    (_: super: {
      neovim-custom = pkgs.wrapNeovimUnstable
        (super.neovim-unwrapped.overrideAttrs
          (oldAttrs: { buildInputs = oldAttrs.buildInputs; })) config;
    })
  ];
  environment.systemPackages = with pkgs; [ neovim-custom ];
  environment.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
  };
}
