{ ... }: {
  programs.vesktop.enable = true;
  programs.vesktop.settings = {
    appBadge = false;
    arRPC = true;
    checkUpdates = false;
    customTitleBar = false;
    minimizeToTray = true;
    clickTrayToShowHide = true;
    tray = true;
    splashTheming = true;
    staticTitle = true;
    hardwareAcceleration = true;
    discordBranch = "stable";
  };
  programs.vesktop.vencord.settings = {
    autoUpdate = false;
    autoUpdateNotification = false;
    notifyAboutUpdates = false;
    useQuickCss = true;
    plugins = {
      PictureInPicture = {
        enabled = true;
        loop = false;
      };
      SilentTyping = {
        enabled = true;
        showIcon = true;
        contextMenu = true;
        isEnabled = true;
      };
      FakeNitro.enabled = true;
      FixYoutubeEmbeds.enabled = true;
      SpotifyCrack.enabled = true;
      ReverseImageSearch.enabled = true;
      NoF1.enabled = true;
    };
  };
}
