{ lib, config, ... }:
{
  imports = [
    ./hardware-configuration.nix
    # ./nvidia.nix
    ./configuration.nix
    ./power-management.nix
    ./syncthing.nix
  ];

  options.desktop.caelestia.enable = lib.mkEnableOption "Enable caelestia";

  config = {
    desktop.caelestia.enable = lib.mkDefault false;
    home-manager.users.vs = lib.mkIf config.desktop.caelestia.enable {
      imports = [ ./caelestia.nix ];
    };
  };
}
