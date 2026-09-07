{ ... }:
{
  imports = [
    ./configuration.nix
    ../../modules/system/openssh.nix
    ../../modules/system/server-defaults.nix
  ];
}
