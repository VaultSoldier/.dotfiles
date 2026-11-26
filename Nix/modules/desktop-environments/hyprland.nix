{
  config,
  lib,
  pkgs,
  ...
}:
let
  scripts_pkgs = with pkgs; [
    socat
    jq
    bc
  ];
in
lib.mkIf config.desktop.hyprland.enable {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
      kdePackages.kwallet
    ];
    config = {
      hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
        # INFO: Secret portal (used by Chromium/Electron safeStorage as a key store)
        "org.freedesktop.impl.portal.Secret" = [ "kwallet" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "Hyprland" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "Hyprland" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "Hyprland" ];
      };
      KDE = {
        default = [ "kde" ];
      };
    };
  };

  services.dbus.packages = [
    pkgs.kdePackages.kwallet # D-Bus activation: org.kde.kwalletd5/6, org.kde.secretservicecompat
  ];

  # INFO: mkDefault: plasma6.nix sets the same option when desktop.plasma6.enable
  # is on, and login.kwallet.package must stay unique.
  security.pam.services.login.kwallet = lib.mkDefault {
    enable = true;
    package = pkgs.kdePackages.kwallet-pam;
  };

  # Enable XDG MIME and menu support
  xdg.mime.enable = true;
  xdg.menus.enable = true;

  # Fix for empty "Open With" menu in Dolphin when running under Hyprland
  # This copies the plasma-applications.menu file from plasma-workspace to /etc/xdg/menus/applications.menu
  environment.etc."xdg/menus/applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  # INFO: fixes missing breeze
  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.kdePackages.breeze}/share"
  ];
  environment.systemPackages =
    with pkgs;
    [
      libnotify # notify-send
      kdePackages.polkit-kde-agent-1
      adwaita-icon-theme # gnome icons for apps
      adwaita-qt
      kdePackages.kwallet # kwalletd6 + ksecretd (Secret Service on top of KWallet)
      kdePackages.kwalletmanager # GUI for the wallet: create it / change its password
    ]
    ++ scripts_pkgs;

  systemd.user.services.plasma-kwallet-pam = {
    description = "Feed the SDDM login password to the PAM-started ksecretd (KWallet unlock)";
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      Slice = "background.slice";
      Environment = [ "PAM_KWALLET5_LOGIN=%t/kwallet5.socket" ];
      ExecStart = "${pkgs.kdePackages.kwallet-pam}/libexec/pam_kwallet_init";
    };
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "KDE PolicyKit authentication agent";
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.polkit-kde-agent-1}/libexec/polkit-kde-authentication-agent-1";
      Restart = "on-abnormal";
    };
  };

  programs.uwsm.enable = true;
  hardware.i2c.enable = true; # needed for uwsm, ddcutil
  users.users.vs.extraGroups = [ "i2c" ];
  programs.gpu-screen-recorder.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
