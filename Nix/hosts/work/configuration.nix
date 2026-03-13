{ config, pkgs, ... }:
{
  networking.hostName = "work";

  boot = {
    initrd.luks.devices."luks-b8abc530-b755-4eff-a41b-f58d9269ac56".device =
      "/dev/disk/by-uuid/b8abc530-b755-4eff-a41b-f58d9269ac56";
    initrd.systemd.enable = true;

    plymouth = {
      enable = true;
    };
    loader.systemd-boot.enable = true;

    # Enable "Silent boot"
    consoleLogLevel = 3;
    initrd.verbose = false;
    resumeDevice = "/dev/mapper/luks-b8abc530-b755-4eff-a41b-f58d9269ac56";
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "resume=/dev/mapper/luks-b8abc530-b755-4eff-a41b-f58d9269ac56"
    ];
    loader.timeout = 0; # Hide the OS choice for bootloaders.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # WARN: DO NOT CHANGE!!!
  system.stateVersion = "25.11"; # Did you read the comment?
}
