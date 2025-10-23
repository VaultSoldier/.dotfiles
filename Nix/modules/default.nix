{ ... }: {
  imports = [
    ./system/audio.nix
    ./system/networking.nix
    ./system/zapret.nix
    ./system/security.nix
    ./system/locale.nix

    ./packages/sddm.nix
    ./packages/code.nix
    ./packages/clash-verge.nix
    ./packages/neovim.nix
    ./packages/kanata.nix
    ./packages/podman.nix
    ./packages/dolphin.nix
    ./packages/virt-manager.nix
    ./packages/cli.nix
    ./packages/gui.nix
  ];
}
