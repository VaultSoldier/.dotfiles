{ ... }:
{
  imports = [ ../../modules/packages/syncthing.nix ];

  services.syncthing = {
    key = "/run/secrets/syncthing_laptop_key";
    cert = "/run/secrets/syncthing_laptop_cert";
  };
}
