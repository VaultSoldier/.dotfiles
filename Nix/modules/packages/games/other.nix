{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.games = {
    lutris.enable = lib.mkEnableOption "Enable lutris";
    osu-lazer.enable = lib.mkEnableOption "Enable osu-lazer";
    prismlauncher.enable = lib.mkEnableOption "Enable prismlauncher";
  };

  config = {
    environment.systemPackages =
      with pkgs;
      lib.concatLists [
        (lib.optionals config.games.lutris.enable [ lutris ])
        (lib.optionals config.games.osu-lazer.enable [ osu-lazer ])
        (lib.optionals config.games.prismlauncher.enable [ prismlauncher ])
      ];
  };
}
