{ pkgs, ... }:

let
  # Wrap WinBox4 to force use of the XCB platform plugin under XWayland
  winbox4Wrapped = pkgs.winbox4.overrideAttrs (drv: rec {
    buildInputs = drv.buildInputs ++ [ pkgs.makeWrapper ];
    postFixup = ''
      wrapProgram $out/bin/WinBox \
        --set QT_QPA_PLATFORM xcb
    '';
  });
in {
  environment.systemPackages = with pkgs; [
    # TODO: Temporary fix. Remove later
    (import (fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/4729404.tar.gz";
      sha256 = "08iy97dmc7d66g9fd31lch0qkl9j29apzhcm8qfl43h7q8nx9p9r";
    }) { system = pkgs.system; }).nextcloud-client
    winbox4Wrapped
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
}
