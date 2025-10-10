{ ... }: {
  imports = [ ./general-stylix.nix ];

  stylix.targets.btop.enable = false;
  stylix.targets.kitty.enable = false;
  stylix.targets.zen-browser.enable = false;
  stylix.targets.vesktop.enable = false;
  stylix.targets.zen-browser.profileNames = [ "default" ];
}
