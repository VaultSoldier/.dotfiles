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
