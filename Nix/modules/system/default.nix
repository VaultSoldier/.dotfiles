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
    ./flatpak.nix
  ];

  system.flatpak.enable = lib.mkDefault false;
  system.wg.enable = lib.mkDefault false;

  programs.nh = {
    enable = true;
    flake = "/home/vs/.dotfiles/Nix";
  };
}
