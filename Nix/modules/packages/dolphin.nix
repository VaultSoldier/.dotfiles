{ pkgs, ... }: {
  services.gvfs.enable = true; # mtp

  environment.systemPackages = with pkgs; [
    kdePackages.dolphin
    kdePackages.konsole
    kdePackages.kdialog
    kdePackages.kio
    kdePackages.kdf # kwikdisk
    kdePackages.kio-fuse
    kdePackages.kio-extras
    kdePackages.kio-admin
    kdePackages.qtwayland
    kdePackages.plasma-integration
    kdePackages.kdegraphics-thumbnailers
    kdePackages.kdesdk-thumbnailers
    kdePackages.kimageformats
    kdePackages.ffmpegthumbs
    kdePackages.breeze-icons
    kdePackages.qtsvg
    kdePackages.kservice
    kdePackages.taglib
    shared-mime-info
    libappimage
    icoutils
  ];
}
