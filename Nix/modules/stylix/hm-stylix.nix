{ ... }: {
  imports = [ ./general-stylix.nix ];

  stylix.targets.btop.enable = false;
  stylix.targets.zen-browser.profileNames = [ "default" ];
}
