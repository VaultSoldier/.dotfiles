{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.vs = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "podman" "adbuser" "kvm" ];
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;
  programs.adb.enable = true;

  services.udisks2.enable = true;
  environment.systemPackages = with pkgs; [ xdg-user-dirs cryfs ];
  environment.variables = {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland";
    NIXOS_OZONE_WL = "1";
  };
}
