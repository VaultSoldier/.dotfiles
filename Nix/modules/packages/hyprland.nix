{ pkgs, ... }:

let
  customized_sddm_astronaut =
    pkgs.sddm-astronaut.override { embeddedTheme = "black_hole"; };
in {
  # Enable XDG MIME and menu support
  xdg.mime.enable = true;
  xdg.menus.enable = true;

  # quickshell
  qt.enable = true;

  # Fix for empty "Open With" menu in Dolphin when running under Hyprland
  # This copies the plasma-applications.menu file from plasma-workspace to /etc/xdg/menus/applications.menu
  environment.etc."/xdg/menus/applications.menu".text = builtins.readFile
    "${pkgs.kdePackages.plasma-workspace}/etc/xdg/menus/plasma-applications.menu";

  services = {
    displayManager.sddm = {
      enable = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      extraPackages = with pkgs; [
        kdePackages.qtbase
        kdePackages.qtwayland
        kdePackages.qtmultimedia
        kdePackages.qtvirtualkeyboard
      ];
      theme = "customized_sddm_astronaut";
      settings = { Theme = { Current = "sddm-astronaut-theme"; }; };
    };
    gnome.gnome-keyring.enable = true;
  };

  environment.systemPackages = with pkgs; [
    customized_sddm_astronaut
    kdePackages.kde-gtk-config
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.sddm-kcm
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
