{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    qt6.qtdeclarative
    qt6.qtbase
    kdePackages.qtdeclarative
    kdePackages.breeze
    kdePackages.breeze-gtk
    nerd-fonts.caskaydia-cove
    papirus-icon-theme
    material-symbols
    gtk3
    lm_sensors
    ddcutil
    hyprpicker # color picker
    pavucontrol
    brightnessctl
    networkmanager
    app2unit
    cava
    aubio
    file
    bluez
    swappy
    grim
    inotify-tools
    xkeyboard-config
    libqalculate
    cliphist
    ydotool
  ];

  programs.gpu-screen-recorder.enable = true;

  environment.variables = {
    CAELESTIA_BD_PATH = "$HOME/.dotfiles/beat_detector";
    CAELESTIA_LIB_DIR = "$HOME/.config/quickshell/caelestia";
    QML2_IMPORT_PATH = "$CAELESTIA_LIB_DIR/qml:$QML2_IMPORT_PATH";
    CAELESTIA_XKB_RULES_PATH =
      "${pkgs.xkeyboard-config}/share/xkeyboard-config-2/rules/base.lst";
  };

  environment.sessionVariables.XDG_DATA_DIRS = [
    "${pkgs.papirus-icon-theme}/share"
    "${pkgs.kdePackages.breeze}/share"
    "${pkgs.material-symbols}/share"
  ];
}
