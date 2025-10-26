{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # TODO: Temporary fix. Remove later
    (import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/4729404.tar.gz";
      sha256 = "08iy97dmc7d66g9fd31lch0qkl9j29apzhcm8qfl43h7q8nx9p9r";
    }) { system = pkgs.system; }).nextcloud-client
    kitty
    mpv
    kdePackages.gwenview
    bitwarden-desktop
    filezilla
    qbittorrent
    sqlitebrowser
    dbeaver-bin
    chromium
    telegram-desktop
    nextcloud-talk-desktop
    onlyoffice-desktopeditors
    rustdesk-flutter
    obsidian
  ];

  programs.amnezia-vpn.enable = true;
  programs.winbox = {
    enable = true;
    package = pkgs.winbox4;
    openFirewall = true;
  };
}
