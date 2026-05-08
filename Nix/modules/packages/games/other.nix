{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.games = {
    prismlauncher.enable = lib.mkEnableOption "Enable prismlauncher";
    lutris.enable = lib.mkEnableOption "Enable lutris";
    osu.enable = lib.mkEnableOption "Enable osu-lazer";
    rpcs3.enable = lib.mkEnableOption "Enable rpcs3";
  };

  config = {
    environment.systemPackages =
      with pkgs;
      lib.concatLists [
        (lib.optionals config.games.prismlauncher.enable [ prismlauncher ])
        (lib.optionals config.games.lutris.enable [ lutris ])
        (lib.optionals config.games.osu.enable [ osu-lazer ])
        (lib.optionals config.games.rpcs3.enable [ rpcs3 ])
      ];
  };
}
