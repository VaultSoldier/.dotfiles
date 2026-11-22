{
  config,
  lib,
  ...
}:
{
  config = lib.mkIf config.system.flatpak.enable {
    system.flatpak = {
      remotes.termix = "https://flatpak.termix.site/termix.flatpakrepo";
      apps = [ "termix:com.karmaa.termix" ];
    };
  };
}
