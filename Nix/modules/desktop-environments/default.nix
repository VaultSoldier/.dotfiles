{ lib, ... }:
{
  imports = [
    ./plasma6.nix
    ./hyprland.nix
  ];

  config = {
    desktop.plasma6.enable = lib.mkDefault false;
    desktop.hyprland.enable = lib.mkDefault false;
  };

  options.desktop = {
    plasma6.enable = lib.mkEnableOption "Enable Plasma 6";
    hyprland.enable = lib.mkEnableOption "Enable Hyprland";
  };

}
