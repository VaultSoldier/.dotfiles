{ lib, ... }:
{
  imports = [
    ./audio.nix
    ./locale.nix
    ./sddm.nix
    ./security.nix
    ./network.nix
    ./sops.nix
    ./wireguard.nix
    ./zapret.nix
    ./flatpak.nix
  ];

  system.flatpak.enable = lib.mkDefault false;
  system.zapret.enable = lib.mkDefault false;
  system.wg.enable = lib.mkDefault false;
}
