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
    kitty
    mpv
    winbox4Wrapped
    kdePackages.gwenview
    bitwarden-desktop
    filezilla
    qbittorrent
    sqlitebrowser
    dbeaver-bin
    chromium
    vesktop
    telegram-desktop
    nextcloud-talk-desktop
    nextcloud-client
    onlyoffice-desktopeditors
    rustdesk-flutter
    obsidian
  ];

  programs.amnezia-vpn.enable = true;

  # Nekoray
  programs.nekoray.enable = true;
  programs.nekoray.tunMode.enable = true;

  # VirtualBox
  users.extraGroups.vboxusers.members = [ "vs" ];
  virtualisation.virtualbox = {
    host.enable = true;
    host.enableKvm = true;
    host.addNetworkInterface = false;
  };
}
