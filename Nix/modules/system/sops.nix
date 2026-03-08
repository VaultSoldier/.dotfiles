{ sops-nix, ... }:
{
  imports = [ sops-nix.nixosModules.sops ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";

  sops.age.keyFile = "/home/vs/.config/sops/age/keys.txt";

  sops.secrets.wireguard_key = { };
}
