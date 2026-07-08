{ ... }:
{
  imports = [
    ./configuration.nix
    ../../modules/system/ssh-server.nix
    ../../modules/system/server.nix
  ];

  services.openssh.settings.AllowUsers = [
    "vs"
    "build"
  ];
}
