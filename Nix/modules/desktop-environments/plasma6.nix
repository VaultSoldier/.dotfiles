{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.desktop.plasma6.enable {
  services = {
    desktopManager.plasma6.enable = true;
  };

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.elisa # Simple music player
    kdePackages.kate # Advanced text editor
    kdePackages.okular # KDE document viewer
    kdePackages.khelpcenter # Software documentation viewer
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];
}
