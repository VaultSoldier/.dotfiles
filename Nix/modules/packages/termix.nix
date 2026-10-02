{ pkgs, ... }:
let
  version = "2.9.0";
  tag = "release-${version}-tag";

  termix-appimage = pkgs.fetchurl {
    url = "https://github.com/Termix-SSH/Termix/releases/download/${tag}/termix_linux_x64_appimage.AppImage";
    sha256 = "sha256-txRP3cK7V61gRXZT8MR9b5mYDWoEY0fEz+gyPauaKOA=";
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
        sha256 = "sha256-2vof0LhtaI85IbipZ9+1MKlL/qHwcrRal6KpGOMlzXE=";
      };
      sizes = {
        "16x16" = "sha256-thCbcfTuPLAXwJyhUbJMhj2EKX9bL2s4x+1W8oZ2KQ8=";
        "24x24" = "sha256-j91GMM8FbJXvB0soZ+JjV0T9J9CK8D5cjyuyfPPXlow=";
        "32x32" = "sha256-vjj3pGTFFW53gHgq6TzsdCZXM50EESXvH7eQmCPLXQI=";
        "48x48" = "sha256-wU/aBt0xLmGcLREf57jmSycdnPq/XL8rso5O4/mSnoE=";
        "64x64" = "sha256-YcjB1/JMLVDxJPbGqX50U7bYna1xxF4wDjiodxg2epY=";
        "128x128" = "sha256-bhUwOIGoqjzDVnBDDb/9mWcoiUdPEgcBVptPSv8AhvE=";
        "256x256" = "sha256-UxRpRUd1OEMQkU9QL6MHsd4o2Uz+3H91K8wlOvTcsf0=";
        "512x512" = "sha256-HBgIJ59SJ+qBPWEGJYjhbSDUvZ9orC/e4rrDjGvzyjg=";
        "1024x1024" = "sha256-vOra/ol/UXy0JGPtgCDsyzK37wzYevnOpIr5TS48nLk=";
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
