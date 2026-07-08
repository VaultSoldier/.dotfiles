{ modulesPath, ... }: {
  imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];

  programs.nano.enable = false;
  users.users.build = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

  boot.isContainer = true;
  system.stateVersion = "26.11";
}
