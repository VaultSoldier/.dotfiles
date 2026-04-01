{ config, pkgs, ... }:
{
  networking.hostName = "agentsmith";

  services.fprintd.tod.driver = pkgs.libfprint-2-tod1-elan;

  boot.kernelPackages = pkgs.linuxPackages_latest;
  boot = {
    initrd.systemd.enable = true;
    initrd.luks.devices."luks-d489ca0b-5100-4f98-aed8-4c862d04e403" = {
      device = "/dev/disk/by-uuid/d489ca0b-5100-4f98-aed8-4c862d04e403";
      crypttabExtraOpts = [ "tpm2-device=/dev/tpmrm0" ];
    };

    plymouth = {
      enable = true;
    };

    initrd.kernelModules = [
      "tpm_tis"
      "tpm_crb"
      "tpm"
      "nvme"
    ];
    consoleLogLevel = 3;
    initrd.verbose = false;
    resumeDevice = "/dev/mapper/luks-d489ca0b-5100-4f98-aed8-4c862d04e403";

    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "resume=/dev/mapper/luks-d489ca0b-5100-4f98-aed8-4c862d04e403"
      # fix for LANGTU LT75PRO-2.4G FN being always active
      "hid_apple.fnmode=2"
      "hid_apple.swap_fn_leftctrl=0"
    ];
    loader.systemd-boot.enable = true;
    loader.timeout = 0; # Hide the OS choice for bootloaders.
  };

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  # WARN: DO NOT CHANGE!!!
  system.stateVersion = "26.05"; # Did you read the comment?
}
