{ pkgs, ... }:

{
  services = { desktopManager.plasma6.enable = true; };

  environment.plasma6.excludePackages = with pkgs;
    [
      kdePackages.elisa # Simple music player aiming to provide a nice experience for its users
    ];

  environment.systemPackages = with pkgs; [
    #kdePackages.discover # Optional: Install if you use Flatpak or fwupd firmware update sevice
    kdePackages.kcolorchooser # A small utility to select a color
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];
}
