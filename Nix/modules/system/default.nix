{ ... }: {
  imports = [
    ./audio.nix
    ./locale.nix
    ./networking.nix
    ./sddm.nix
    ./security.nix
    ./flatpak.nix
    ./zapret.nix
  ];
}
