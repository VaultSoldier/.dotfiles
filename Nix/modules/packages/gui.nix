{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nextcloud-client
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
    # rustdesk-flutter
    obsidian
  ];

  programs.amnezia-vpn.enable = true;
  programs.winbox = {
    enable = true;
    package = pkgs.winbox4;
    openFirewall = true;
  };
}
