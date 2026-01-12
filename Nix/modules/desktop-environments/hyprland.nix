{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.desktop.hyprland.enable {
  xdg.portal = {
    enable = true;
    xdgOpenUsePortal = false;
    extraPortals = with pkgs; [
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
    configPackages = with pkgs; [
      xdg-desktop-portal-hyprland
      kdePackages.xdg-desktop-portal-kde
    ];
    config = {
      Hyprland = {
        default = [ "hyprland" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "hyprland" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "hyprland" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "hyprland" ];
      };
      KDE = {
        default = [ "kde" ];
        "org.freedesktop.impl.portal.ScreenCast" = [ "kde" ];
        "org.freedesktop.impl.portal.Screenshot" = [ "kde" ];
        "org.freedesktop.impl.portal.RemoteDesktop" = [ "kde" ];
      };
    };
  };

  # Enable XDG MIME and menu support
  xdg.mime.enable = true;
  xdg.menus.enable = true;

  # Fix for empty "Open With" menu in Dolphin when running under Hyprland
  # This copies the plasma-applications.menu file from plasma-workspace to /etc/xdg/menus/applications.menu
  environment.etc."/xdg/menus/applications.menu".text =
    builtins.readFile "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services = {
    gnome.gnome-keyring.enable = true;
  };

  environment.systemPackages = with pkgs; [
    kdePackages.ark
    adwaita-icon-theme # gnome icons for apps
    adwaita-qt
    jq
  ];

  programs.uwsm.enable = true;
  programs.gpu-screen-recorder.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
