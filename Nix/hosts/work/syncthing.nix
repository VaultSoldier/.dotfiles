{ ... }:
{
  imports = [ ../../modules/packages/syncthing.nix ];

  services.syncthing = {
    key = "/run/secrets/syncthing_work_key";
    cert = "/run/secrets/syncthing_work_cert";
  };
}
