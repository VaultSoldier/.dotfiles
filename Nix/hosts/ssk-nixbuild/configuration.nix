{ modulesPath, ... }: {
  imports = [ (modulesPath + "/virtualisation/proxmox-lxc.nix") ];

  boot.isContainer = true;

  systemd.suppressedSystemUnits = [
    "dev-mqueue.mount"
    "sys-kernel-debug.mount"
    "sys-fs-fuse-connections.mount"
  ];

  users.users."root".openssh.authorizedKeys.keys = [
    # tf_root_vm_default_id_ed25519
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIL2CicVsZrp3aT4YukHy0TTnWkahlEZiWAf5yvKG5lYs"
    # id_ed25519
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFl6mK/MgyQ/PM1/JKllrjldJjYuN4BKPgMfcIb6wPR"
    # nixos_builders_id_ed25519
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFOGNmRtpH21mg+LKkUdcuczVEoppkl5Gwtiyv+uKehJ"
  ];

  system.stateVersion = "26.11";
}
