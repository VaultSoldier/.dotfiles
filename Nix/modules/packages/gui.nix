{ pkgs, ... }:
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
    (onlyoffice-desktopeditors.override {
      extraFontPackages = [
        corefonts
        vista-fonts
      ];
    })
    rustdesk
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
}
