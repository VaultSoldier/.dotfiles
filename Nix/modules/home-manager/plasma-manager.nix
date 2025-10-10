{ ... }: {
  programs.plasma = {
    enable = true;

    configFile.kdeglobals."General" = {
      TerminalApplication = "kitty";
      TerminalService = "kitty.desktop";
    };
    workspace.theme = "breeze-dark";
    workspace.lookAndFeel = "org.kde.breezedark.desktop";
  };
}
