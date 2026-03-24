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

  config.environment.variables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
    ZDOTDIR="$HOME/.config/zsh";
  };
}
