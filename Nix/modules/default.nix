{ ... }: {
  imports = [
    ./system/audio.nix
    ./system/networking.nix
    ./system/security.nix
    ./system/locale.nix

    ./packages/sddm.nix
    ./packages/code.nix
    ./packages/games.nix
    ./packages/kanata.nix
    ./packages/podman.nix
    ./packages/dolphin.nix
    ./packages/cli.nix
    ./packages/gui.nix
  ];
}
