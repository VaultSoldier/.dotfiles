{ ... }: {
  programs.vesktop.enable = true;
  programs.vesktop.settings = {
    appBadge = false;
    arRPC = true;
    checkUpdates = false;
    customTitleBar = false;
    disableMinSize = false;
    minimizeToTray = true;
    clickTrayToShowHide = true;
    tray = true;
    splashTheming = true;
    staticTitle = true;
    hardwareAcceleration = true;
    discordBranch = "stable";
  };
}
