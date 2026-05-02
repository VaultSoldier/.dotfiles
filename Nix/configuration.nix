{ pkgs, ... }:

{
  nixpkgs.config.allowUnfree = true;
  hardware.enableAllFirmware = true;
  hardware.enableAllHardware = true;

  nix = {
    package = pkgs.lixPackageSets.stable.lix;
    settings.experimental-features = [
      "nix-command"
      "flakes"
    ];
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 30d";
    };
    settings.auto-optimise-store = true;
    settings.use-xdg-base-directories = true;
  };

  xdg.menus.enable = true;

  users.users.vs = {
    isNormalUser = true;
    description = "John";
    extraGroups = [
      "plugdev"
      "wheel"
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
    git-extras
    gitleaks
    wget
    curl
  ];

  boot.kernelParams = [
    # fix for LANGTU LT75PRO-2.4G FN being always active
    "hid_apple.fnmode=2"
    "hid_apple.swap_fn_leftctrl=0"
  ];
}
