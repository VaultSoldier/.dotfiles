{ ... }:
{
  imports = [
    ./configuration.nix
    ../../modules/system/ssh-server.nix
    ../../modules/system/server.nix
  ];
}
