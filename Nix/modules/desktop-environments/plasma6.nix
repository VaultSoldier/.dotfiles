{
  config,
  lib,
  pkgs,
  ...
}:
lib.mkIf config.desktop.plasma6.enable {
  services = {
    desktopManager.plasma6.enable = true;
    fwupd.enable = true;
  };

  programs.kde-pim = {
    enable = true;
    kmail = false;
    kontact = false;
    merkuro = false;
  };

  environment.plasma6.excludePackages = with pkgs; [
    kdePackages.akonadi-import-wizard
    kdePackages.elisa # Simple music player
    kdePackages.kate # Advanced text editor
    kdePackages.ktexteditor # kate dep
    kdePackages.okular # KDE document viewer
    kdePackages.khelpcenter # Software documentation viewer
  ];

  environment.systemPackages = with pkgs; [
    kdePackages.kolourpaint # Easy-to-use paint program
    kdePackages.ksystemlog # KDE SystemLog Application
    wl-clipboard # Command-line copy/paste utilities for Wayland
  ];
}
