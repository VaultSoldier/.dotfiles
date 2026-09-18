{ pkgs, ... }:

{
  users.users.vs.extraGroups = [ "podman" ];

  virtualisation = {
    containers.enable = true;
    containers.registries.settings = {
      registry = [
        { location = "docker.io"; }
        { location = "quay.io"; }
      ];
    };
    podman = {
      enable = true;
      dockerCompat = true;
      defaultNetwork.settings.dns_enabled = true;
    };
  };

  boot.binfmt = {
    emulatedSystems = [
      "aarch64-linux"
      "armv7l-linux"
    ];
    preferStaticEmulators = true;
  };

  environment.systemPackages = with pkgs; [
    dive
    podman-tui
    #podman-desktop
    podman-compose
    distrobox
  ];
}
