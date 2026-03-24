{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;
  nix.settings.use-xdg-base-directories = true;
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };

  xdg.menus.enable = true;

  users.users.vs = {
    isNormalUser = true;
    description = "John";
    extraGroups = [
      "networkmanager"
      "plugdev"
      "wheel"
      "podman"
      "adbuser"
      "kvm"
    ];
  };

  # system-wide zsh
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  environment.variables = {
    ZDOTDIR = "$HOME/.config/zsh";
  };

  services.udisks2.enable = true;
  services.fwupd.enable = true;

  environment.systemPackages = with pkgs; [
    man-pages
    fwupd
    cryfs
    file
    git
    gitleaks
    wget
    curl
  ];
}
