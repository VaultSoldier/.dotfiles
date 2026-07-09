{ pkgs, inputs, ... }:
{
  imports = [ inputs.sops-nix.nixosModules.sops ];

  environment.systemPackages = with pkgs; [ sops ];

  sops.defaultSopsFile = ../../secrets/secrets.yaml;
  sops.defaultSopsFormat = "yaml";
  sops.age.keyFile = "/home/vs/.config/sops/age/keys.txt";

  sops.secrets.wireguard_key = { };
  sops.secrets.syncthing_gui_pass = {
    mode = "0440";
    owner = "vs";
    group = "users";
  };
  sops.secrets.build_key = {
    mode = "0400";
    owner = "root";
    group = "root";
  };
  sops.secrets.syncthing_desktop_key = { };
  sops.secrets.syncthing_desktop_cert = { };
  sops.secrets.syncthing_agentsmith_key = { };
  sops.secrets.syncthing_agentsmith_cert = { };
}
