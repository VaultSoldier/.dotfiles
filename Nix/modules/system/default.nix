{ lib, ... }:
{
  imports = [
    ./audio.nix
    ./locale.nix
    ./sddm.nix
    ./security.nix
    ./network.nix
    ./wireguard.nix
    ./zapret.nix
    ./flatpak.nix
  ];

  system.zapret.enable = lib.mkDefault false;
  system.flatpak.enable = lib.mkDefault false;
  system.wg.enable = lib.mkDefault false;
}
