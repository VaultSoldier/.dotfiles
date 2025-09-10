{ pkgs, ... }:

{
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.vs = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
  };

  environment.systemPackages = with pkgs; [
    xdg-user-dirs
    bibata-cursors
    cryfs
  ];

  services.udisks2.enable = true;
}
