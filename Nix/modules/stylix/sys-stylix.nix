{ ... }: {
  imports = [ ./general-stylix.nix ];

  stylix.enable = true;
  stylix.targets.plymouth.enable = false;
}
