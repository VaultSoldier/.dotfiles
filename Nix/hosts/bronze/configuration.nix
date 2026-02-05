{ config, pkgs, ... }:
{
  networking.hostName = "bronze";

  boot = {
    kernelPackages = pkgs.linuxPackages_latest;

    plymouth = {
      enable = true;
      themePackages = [ pkgs.mikuboot ];
      theme = "mikuboot";
    };

    loader.systemd-boot.enable = true;
    loader.timeout = 0; # Hide the OS choice for bootloaders.

    initrd.verbose = false;
    consoleLogLevel = 3;
    kernelParams = [
      "quiet"
      "splash"
      "boot.shell_on_fail"
      "udev.log_priority=3"
      "rd.systemd.show_status=auto"
      "pcie_aspm=off" # fixes QCA9377 wifi
      "ath10k_core.skip_otp=y" # fixes QCA9377 wifi
      "ath10k_core.nohwcrypt=1" # fixes QCA9377 wifi
    ];
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
