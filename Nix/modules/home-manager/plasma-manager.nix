{ inputs, pkgs, ... }:
{
  imports = [ inputs.plasma-manager.homeModules.plasma-manager ];

  home.packages = [ pkgs.bibata-cursors ];
  # set .desktop for service hotkey
  home.file = {
    "/home/vs/.local/share/applications/net.local.kitty.desktop".text = ''
      [Desktop Entry]
      Exec=kitty /home/vs/.dotfiles/scripts/kitty-tmux.zsh
      Name=kitty-tmux-wrapped
      NoDisplay=true
      StartupNotify=false
      Type=Application
      X-KDE-GlobalAccel-CommandShortcut=true
    '';
  };

  programs.plasma = {
    enable = true;

    configFile.kdeglobals."General" = {
      TerminalApplication = "kitty";
      TerminalService = "kitty.desktop";
    };
    workspace.theme = "breeze-dark";
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
    workspace.cursor.theme = "Bibata-Modern-Classic";

    configFile.kdeglobals = {
      Shortcuts.Help = "";
      Shortcuts.SaveAs = "Ctrl+Alt+S";
    };

    shortcuts = {
      "services/net.local.kitty.desktop"._launch = "Meta+T";
      "services/zen-twilight.desktop"._launch = "Meta+B";
      "KDE Keyboard Layout Switcher"."Switch to Next Keyboard Layout" = "Alt+Shift";
      org_kde_powerdevil.powerProfile = [ "Battery" ];
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
      "services/org.kde.konsole.desktop"._launch = [ ];
      "services/org.kde.spectacle.desktop".RectangularRegionScreenShot = [
        "Meta+Shift+Print"
        "Meta+Ctrl+S"
      ];
      "services/org.kde.spectacle.desktop"._launch = "Print";
      "services/systemsettings.desktop"._launch = [
        "Meta+I"
        "Tools"
      ];
    };
  };
}
