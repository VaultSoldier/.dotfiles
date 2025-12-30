{ pkgs, ... }:
{
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
