{ ... }: {
  imports = [
    ./configuration.nix
    ./hardware-configuration.nix
    ./power-management.nix
    ./nvidia.nix
  ];
}
