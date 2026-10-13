{ pkgs, ... }:
let
  version = "26.10.1";
  tag = "v${version}";

  termix-appimage = pkgs.fetchurl {
    url = "https://github.com/Termix-SSH/Termix/releases/download/${tag}/termix_linux_x64_appimage.AppImage";
    sha256 = "sha256-DVEFLMYs7M4Z616C9bLJW4sjwXckCWsLp8gWsVCOniI=";
  };
  termix = pkgs.appimageTools.wrapType2 {
    pname = "termix";
    inherit version;
    src = termix-appimage;
  };
  termix-desktop = pkgs.makeDesktopItem {
    name = "termix";
    desktopName = "Termix";
    comment = "Self-hosted SSH and remote desktop management";
    exec = "${termix}/bin/termix %U";
    icon = "termix";
    terminal = false;
    type = "Application";
    categories = [
      "Network"
      "RemoteAccess"
      "Utility"
    ];
  };

  # Install the hicolor icon set so the desktop entry's Icon=termix resolves.
  # Fetched from the upstream repo at the release tag (the AppImage can't be
  # executed in the Nix build sandbox, and it's too large to repurpose).
  termix-icons =
    let
      icon =
        name: sha256:
        pkgs.fetchurl {
          url = "https://raw.githubusercontent.com/Termix-SSH/Termix/${tag}/public/icons/${name}";
          inherit sha256;
        };
      svg = pkgs.fetchurl {
        url = "https://raw.githubusercontent.com/Termix-SSH/Termix/${tag}/public/icon.svg";
        sha256 = "sha256-/khZwx7HJwJoLE1CEblGUvM8TM40ct6bu8rZ6uwBi98=";
      };
      sizes = {
        "16x16" = "sha256-pbpnL2YVnEOCFDT/NXeffJJiiGNqKKd5jCUMCEcnKBE=";
        "24x24" = "sha256-ld/eokEgNx+wddPRSuuL+mtcZ/9E2Kshzxe6xCfjUGw=";
        "32x32" = "sha256-I5nzOyqTkjBbuaRZAb1e+w//5dfW0Ee6GZkjpT/QyyQ=";
        "48x48" = "sha256-gpkYjml5CKDx2LV61Po38ASaNjQdU2XLbPQLHW6GBms=";
        "64x64" = "sha256-ksmRris2ZI5NZErBM+ffEa0k3+8xwjaFvpfSvyZDXMg=";
        "128x128" = "sha256-MdSzgozIPW/JANrsBrkpWNn3Z9yt681cWng0KGqI6Ko=";
        "256x256" = "sha256-3q+a/qrbILNHEYj1JX+cYou0CVRkSfTTK19ck6bUafM=";
        "512x512" = "sha256-TYCkoV9Ciov6H4VDSgQjAbQM8oQWfg6iKs6zSDybLUA=";
        "1024x1024" = "sha256-AY4ETdVqu9ajAXB2COydJfNU16FicW6W2F9KPJuCLGo=";
      };
      installPngs = pkgs.lib.concatStringsSep "\n" (
        pkgs.lib.mapAttrsToList (size: sha256: ''
          mkdir -p $out/share/icons/hicolor/${size}/apps
          cp ${icon "${size}.png" sha256} $out/share/icons/hicolor/${size}/apps/termix.png
        '') sizes
      );
    in
    pkgs.stdenvNoCC.mkDerivation rec {
      pname = "termix-icons";
      inherit version;
      dontUnpack = true;
      installPhase = ''
        runHook preInstall
        mkdir -p $out/share/icons/hicolor/scalable/apps
        cp ${svg} $out/share/icons/hicolor/scalable/apps/termix.svg
        ${installPngs}
        runHook postInstall
      '';
    };
in
{
  environment.systemPackages = [
    termix
    termix-desktop
    termix-icons
  ];
}
