{ pkgs, ... }:

{
  xdg.portal = {
    xdgOpenUsePortal = true;
    enable = true;
    configPackages = with pkgs; [
      xdg-desktop-portal-gtk
      kdePackages.xdg-desktop-portal-kde
      xdg-desktop-portal-hyprland
    ];
    config = {
      common = {
        default = [ "hyprland;gtk" ];
        "org.freedesktop.impl.portal.FileChooser" = [ "kde" ];
      };
    };
  };

  # Enable XDG MIME and menu support
  xdg.mime.enable = true;
  xdg.menus.enable = true;

  # quickshell
  qt.enable = true;

  # Fix for empty "Open With" menu in Dolphin when running under Hyprland
  # This copies the plasma-applications.menu file from plasma-workspace to /etc/xdg/menus/applications.menu
  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services = { gnome.gnome-keyring.enable = true; };

  environment.systemPackages = with pkgs; [
    kdePackages.kde-gtk-config
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.ark
    adwaita-icon-theme # gnome icons for apps
    adwaita-qt
    playerctl
    wl-clipboard
  ];

  programs.uwsm.enable = true;
  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
}
