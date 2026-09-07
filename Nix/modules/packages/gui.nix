{ pkgs, ... }:
let
  termix-appimage = pkgs.fetchurl {
    url = "https://github.com/Termix-SSH/Termix/releases/download/release-2.7.1-tag/termix_linux_x64_appimage.AppImage";
    sha256 = "0mxdsccjmp1yla8rclqpzgygfxp8xh3i84qz6nbgj2kxmm4km4ad";
  };

  termix = pkgs.appimageTools.wrapType2 {
    pname = "termix";
    version = "2.7.1";
    src = termix-appimage;
  };

  termix-desktop = pkgs.makeDesktopItem {
    name = "termix";
    desktopName = "Termix";
    comment = "Self-hosted SSH and remote desktop management";
    exec = "${termix}/bin/termix %U";
    icon = "termix";
    terminal = false;
    type = "Application";
    categories = [
      "Network"
      "RemoteAccess"
      "Utility"
    ];
  };
in
{
  environment.systemPackages = with pkgs; [
    termix
    termix-desktop
    mpv
    kitty
    kdePackages.gwenview
    qbittorrent
    sqlitebrowser
    dbeaver-bin
    chromium
    telegram-desktop
    bitwarden-desktop
    nextcloud-client
    nextcloud-talk-desktop
    onlyoffice-desktopeditors
    rustdesk
    virt-viewer # spice viewer
    obsidian
    # open-scq30
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
