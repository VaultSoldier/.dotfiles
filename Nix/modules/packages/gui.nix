{ pkgs, inputs, ... }:
let
  # separate instance so the package set doesn't inherit the nixos-unstable config
  nixpkgs-stable = import inputs.nixpkgs-stable {
    system = pkgs.system;
    config.allowUnfree = true;
  };
in
{
  environment.systemPackages = with pkgs; [
    mpv
    kitty
    kdePackages.gwenview
    qbittorrent
    sqlitebrowser
    dbeaver-bin
    chromium
    telegram-desktop
    nextcloud-client
    nextcloud-talk-desktop
    onlyoffice-desktopeditors
    nixpkgs-stable.rustdesk
    virt-viewer # spice viewer
    obsidian
    easyeffects
    open-scq30
  ];

  programs.amnezia-vpn = {
    enable = true;
  };
  programs.winbox = {
    enable = true;
    package = pkgs.winbox4;
    openFirewall = true;
  };
  programs.throne = {
    enable = true;
    tunMode.enable = true;
  };
  programs.localsend = {
    enable = true;
    openFirewall = true;
  };

  # onlyoffice has trouble with symlinks: https://github.com/ONLYOFFICE/DocumentServer/issues/1859
  system.userActivationScripts = {
    copy-fonts-local-share = {
      text = ''
        rm -rf ~/.local/share/fonts
        mkdir -p ~/.local/share/fonts
        cp ${pkgs.corefonts}/share/fonts/truetype/* ~/.local/share/fonts/
        cp ${pkgs.vista-fonts}/share/fonts/truetype/* ~/.local/share/fonts/
        chmod 544 ~/.local/share/fonts
        chmod 444 ~/.local/share/fonts/*
      '';
    };
  };
}
