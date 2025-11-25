{ ... }: {
  imports = [
    ./code.nix
    ./neovim.nix
    ./kanata.nix
    ./podman.nix
    ./dolphin.nix
    ./virt-manager.nix
    ./cli.nix
    ./gui.nix
  ];
}
