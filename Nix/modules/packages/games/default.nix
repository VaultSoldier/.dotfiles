{ pkgs, lib, ... }:
{
  imports = [
    ./other.nix
    ./steam.nix
  ];
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [ mangohud ];

  games.steam.enable = lib.mkDefault true;
  games.prismlauncher.enable = lib.mkDefault true;
  games.lutris.enable = lib.mkDefault false;
  games.osu.enable = lib.mkDefault false;
  games.rpcs3.enable = lib.mkDefault false;
}
