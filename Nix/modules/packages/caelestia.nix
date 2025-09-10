{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    kdePackages.qtdeclarative
    kdePackages.kde-gtk-config
    kdePackages.breeze
    kdePackages.breeze-gtk
    nerd-fonts.caskaydia-cove
    papirus-icon-theme
    material-symbols
    gtk3
    lm_sensors
    ddcutil
    hyprpicker
    pavucontrol
    brightnessctl
    networkmanager
    app2unit
    cava
    aubio
    fish
    file
    bluez
    swappy
    grim
    inotify-tools
    libqalculate
    wl-clipboard
    cliphist
  ];
}
