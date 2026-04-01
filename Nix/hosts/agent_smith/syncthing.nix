{ ... }:
{
  imports = [ ../../modules/packages/syncthing.nix ];

  services.syncthing = {
    key = "/run/secrets/syncthing_agent_smith_key";
    cert = "/run/secrets/syncthing_agent_smith_cert";
  };
}
