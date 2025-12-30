{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.games = {
    steam.enable = lib.mkEnableOption "Enable steam";
  };

  config = lib.mkIf config.games.steam.enable {
    environment.systemPackages = with pkgs; [ protonplus ];
    programs.steam = {
      enable = true;
      gamescopeSession.enable = true;
      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
    };
  };
}
