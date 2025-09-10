{
  imports = [
    ./system/audio.nix
    ./system/networking.nix
    ./system/security.nix
    ./system/locale.nix
    ./system/flatpak.nix

    ./packages/cli.nix
    ./packages/gui.nix
    ./packages/code.nix
    ./packages/games.nix
    ./packages/hyprland.nix
    ./packages/kanata.nix
    ./packages/neovim.nix
    ./packages/podman.nix
    ./packages/dolphin.nix
  ];
}
