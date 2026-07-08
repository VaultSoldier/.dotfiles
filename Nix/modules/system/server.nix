{ pkgs, ... }: {
  imports = [ ../packages/neovim.nix ];

  environment.systemPackages = with pkgs; [
    vim
    wget
    curl
    git
  ];

  programs.nano.enable = false;
  time.timeZone = "Asia/Yekaterinburg";

  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 30d";
  };
  nix.settings.auto-optimise-store = true;
}
