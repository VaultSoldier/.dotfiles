{ pkgs, ... }: {
  imports = [ ../packages/neovim.nix ];

  environment.systemPackages = with pkgs; [
    htop
    wget
    curl
    git
  ];

  programs.nano.enable = false;
  time.timeZone = "Asia/Yekaterinburg";

  users.users.vs = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.openssh.settings.AllowUsers = [
    "vs"
    "root"
  ];

  users.users."root".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFl6mK/MgyQ/PM1/JKllrjldJjYuN4BKPgMfcIb6wPR"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIFOGNmRtpH21mg+LKkUdcuczVEoppkl5Gwtiyv+uKehJ"
  ];
  users.users."vs".openssh.authorizedKeys.keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICFl6mK/MgyQ/PM1/JKllrjldJjYuN4BKPgMfcIb6wPR"
  ];

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;

  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;
}
