{ inputs, ... }:
{
  imports = [
    inputs.stylix.nixosModules.stylix
    ./general-stylix.nix
  ];
  home-manager.users.vs.imports = [ ./hm-stylix.nix ];

  stylix.enable = true;
  stylix.targets.plymouth.enable = false;

  # TODO: Remove when fixed
  stylix.targets.kmscon.enable = false;
}
