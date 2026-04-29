{ lib, ... }:
{
  imports = [
    ./audio.nix
    ./locale.nix
    ./sddm.nix
    ./security.nix
    ./network.nix
    ./power-management.nix
    ./sops.nix
    ./flatpak.nix
    ./fprintd.nix
    ./wireguard.nix
  ];

  system.flatpak.enable = lib.mkDefault false;
  system.fprintd.enable = lib.mkDefault false;
  system.power_management.enable = lib.mkDefault false;
  system.wg.enable = lib.mkDefault false;

  programs.nh = {
    enable = true;
    flake = "/home/vs/.dotfiles/Nix";
  };
}
