{ pkgs, lib, ... }: {
  imports = [ ./other.nix ./steam.nix ];
  programs.gamemode.enable = true;
  environment.systemPackages = with pkgs; [ mangohud ];

  games.steam.enable = lib.mkDefault true;

  games.lutris.enable = lib.mkDefault true;
  games.osu-lazer.enable = lib.mkDefault true;
  games.prismlauncher.enable = lib.mkDefault true;
  games.nexusmods.enable = lib.mkDefault true;
}
