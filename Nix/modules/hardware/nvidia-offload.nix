{
  lib,
  pkgs,
  config,
  ...
}:
let
  patchDesktop =
    pkg: desktopName:
    pkgs.runCommand "patched-desktop-${desktopName}" { } ''
      mkdir -p $out/share/applications
      sed -E "s#^Exec=([^ ]*)#Exec=nvidia-offload ${pkg}/bin/\1#" \
        < ${pkg}/share/applications/${desktopName}.desktop \
        > $out/share/applications/${desktopName}.desktop
    '';
  makeWrapper =
    pkg: desktopName:
    pkgs.writeShellScriptBin desktopName ''
      exec nvidia-offload ${pkg}/bin/${desktopName} "$@"
    '';
  allApps = config.nvidiaOffload.baseApps ++ config.nvidiaOffload.extraApps;
in
{
  options.nvidiaOffload = {
    baseApps = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ "kitty" ];
      description = "Always offloaded apps.";
    };
    extraApps = lib.mkOption {
      type = with lib.types; listOf str;
      default = [ ];
      description = "Machine-specific offloaded apps.";
    };
  };

  config = {
    home-manager.sharedModules = [
      {
        xdg.desktopEntries.zen-twilight = {
          name = "Zen Browser Twilight";
          exec = "nvidia-offload zen-twilight %u";
          icon = "zen-twilight";
          terminal = false;
          categories = [
            "Network"
            "WebBrowser"
          ];
          mimeType = [
            "text/html"
            "x-scheme-handler/http"
            "x-scheme-handler/https"
          ];
        };
      }
    ];

    environment.systemPackages = lib.concatMap (desktopName: [
      (patchDesktop pkgs.${desktopName} desktopName)
      (makeWrapper pkgs.${desktopName} desktopName)
    ]) allApps;
  };
}
