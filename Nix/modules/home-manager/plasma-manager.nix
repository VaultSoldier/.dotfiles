{ inputs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  programs.plasma = {
    enable = true;

    configFile.kdeglobals."General" = {
      TerminalApplication = "kitty";
      TerminalService = "kitty.desktop";
    };
    workspace.theme = "breeze-dark";
    workspace.lookAndFeel = "org.kde.breezedark.desktop";

    configFile.kdeglobals = {
      Shortcuts.Help = "";
      Shortcuts.SaveAs = "Ctrl+Alt+S";
    };
    shortcuts = {
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Shift";
      kwin."Edit Tiles" = [ ];
      kwin."Window Close" = [
        "Alt+F4"
        "Meta+Q"
      ];
      mediacontrol.previousmedia = [
        "Meta+F2"
        "Media Previous"
      ];
      mediacontrol.nextmedia = [
        "Meta+F3"
        "Media Next"
      ];
      mediacontrol.playpausemedia = [
        "Media Play"
        "Meta+F1"
      ];
      mediacontrol.mediavolumedown = [ ];
      mediacontrol.mediavolumeup = [ ];

      plasmashell."manage activities" = "";
      "services/kitty.desktop"._launch = "Meta+T";
      "services/org.kde.konsole.desktop"._launch = [ ];
      "services/org.kde.spectacle.desktop".RectangularRegionScreenShot = [
        "Meta+Shift+Print"
        "Ctrl+Shift+S"
      ];
      "services/org.kde.spectacle.desktop"._launch = "Print";
      "services/systemsettings.desktop"._launch = [
        "Meta+I"
        "Tools"
      ];
    };
  };
}
