{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.vs = {
    isNormalUser = true;
    description = "David";
    extraGroups = [ "networkmanager" "wheel" "podman" ];
  };
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

  services.udisks2.enable = true;
  environment.systemPackages = with pkgs; [
    xdg-user-dirs
    bibata-cursors
    cryfs
  ];

}
