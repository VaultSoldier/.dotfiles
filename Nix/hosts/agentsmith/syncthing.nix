{ ... }:
{
  imports = [ ../../modules/packages/syncthing.nix ];

  services.syncthing = {
    key = "/run/secrets/syncthing_agentsmith_key";
    cert = "/run/secrets/syncthing_agentsmith_cert";
  };
}
