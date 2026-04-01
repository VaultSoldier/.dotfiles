{ pkgs, sops-nix, ... }:
{
  imports = [ sops-nix.nixosModules.sops ];

  environment.systemPackages = with pkgs; [ sops ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/vs/.config/sops/age/keys.txt";

  sops.secrets.wireguard_key = { };
  sops.secrets.syncthing_gui_pass = {
    owner = "vs";
    group = "users";
    mode = "0440";
  };
  sops.secrets.syncthing_laptop_key = { };
  sops.secrets.syncthing_laptop_cert = { };

  sops.secrets.syncthing_agentsmith_key = { };
  sops.secrets.syncthing_agentsmith_cert = { };
}
