{ lib, ... }:
{
  imports = [
    ./audio.nix
    ./builders.nix
    ./locale.nix
    ./sddm.nix
    ./security.nix
    ./network.nix
    ./openssh.nix
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
  system.ssh.enable = lib.mkDefault true;

  programs.nh = {
    enable = true;
    flake = "/home/vs/.dotfiles/Nix";
  };
}
