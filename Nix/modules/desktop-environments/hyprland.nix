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
    ];
    config = {
      hyprland = {
        default = [
          "hyprland"
          "kde"
        ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "Hyprland" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "Hyprland" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "Hyprland" ];
      };
      KDE = {
        default = [ "kde" ];
      };
    };
  };

  services.gnome.gnome-keyring.enable = true;

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
      gtk4.dev
      kdePackages.ark
      adwaita-icon-theme # gnome icons for apps
      adwaita-qt
    ]
    ++ scripts;

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
