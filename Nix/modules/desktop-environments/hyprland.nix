{
  config,
  lib,
  pkgs,
  ...
}:
let
  scripts = with pkgs; [
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
      kdePackages.kwallet # portal impl for org.freedesktop.impl.portal.Secret (was provided by gnome-keyring)
    ];
    config = {
      hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
        # INFO: Secret portal (used by Chromium/Electron safeStorage as a key store)
        # was served by gnome-keyring; kwallet's impl has UseIn=kde so name it
        # explicitly for the Hyprland session.
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
      kdePackages.ark
      kdePackages.polkit-kde-agent-1
      adwaita-icon-theme # gnome icons for apps
      adwaita-qt
      kdePackages.kwallet # kwalletd6 + ksecretd (Secret Service on top of KWallet)
      kdePackages.kwalletmanager # GUI for the wallet: create it / change its password
    ]
    ++ scripts;

  systemd.user.services.kwalletd6 = {
    description = "KDE Wallet daemon";
    # Do not autostart via graphical-session.target.
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.kwallet}/bin/kwalletd6";
      Restart = "on-failure";
    };
  };

  systemd.user.services.ksecretd = {
    description = "KDE Wallet Secret Service compatibility daemon";
    partOf = [ "graphical-session.target" ];
    after = [ "kwalletd6.service" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.kdePackages.kwallet}/bin/ksecretd";
      Restart = "on-failure";
    };
  };

  systemd.user.services.polkit-kde-authentication-agent-1 = {
    description = "KDE PolicyKit authentication agent";
    # Do not autostart via graphical-session.target.
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecCondition = "${pkgs.bash}/bin/bash -lc 'case \"$XDG_CURRENT_DESKTOP\" in *Hyprland*|hyprland) exit 0;; *) exit 1;; esac'";
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
