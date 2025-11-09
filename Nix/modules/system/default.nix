{ lib, ... }: {
  imports = [
    ./audio.nix
    ./locale.nix
    ./network.nix
    ./sddm.nix
    ./security.nix
    ./flatpak.nix
    ./zapret.nix
  ];

  system.zapret.enable = lib.mkDefault false;
  system.flatpak.enable = lib.mkDefault false;
}
