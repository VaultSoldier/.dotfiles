{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    mpv
    kitty
    kdePackages.gwenview
    filezilla
    qbittorrent
    sqlitebrowser
    dbeaver-bin
    chromium
    telegram-desktop
    bitwarden-desktop
    nextcloud-client
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
