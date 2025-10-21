{
  xdg.configFile."mimeapps.list".force = true;
  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "x-scheme-handler/terminal" = "kitty.desktop";
      "x-scheme-handler/file" = [ "org.kde.dolphin.desktop" ];
      "x-directory/normal" = [ "org.kde.dolphin.desktop" ];
      "inode/directory" = [ "org.kde.dolphin.desktop" ];
      "application/x-ms-dos-executable" = [ "wine.desktop" ];
      ### TEXT EDITOR ###
      "text/plain" = [ "nvim.desktop" ];
      "text/markdown" = [ "nvim.desktop" ];
      "application/json" = [ "nvim.desktop" ];
      "application/x-yaml" = [ "nvim.desktop" ];
      "application/x-sh" = [ "nvim.desktop" ];
      ### BROWSER ###
      "x-scheme-handler/chrome" = [ "zen-beta.desktop" ];
      "x-scheme-handler/http" = [ "zen-beta.desktop" ];
      "x-scheme-handler/https" = [ "zen-beta.desktop" ];
      "application/x-extension-htm" = [ "zen-beta.desktop" ];
      "application/x-extension-html" = [ "zen-beta.desktop" ];
      "application/x-extension-shtml" = [ "zen-beta.desktop" ];
      "application/x-extension-xht" = [ "zen-beta.desktop" ];
      "application/x-extension-xhtml" = [ "zen-beta.desktop" ];
      "application/xhtml+xml" = [ "zen-beta.desktop" ];
      "text/html" = [ "zen-beta.desktop" ];
      ### IMAGES ###
      "image/png" = [ "org.kde.gwenview.desktop" ];
      "image/jpeg" = [ "org.kde.gwenview.desktop" ];
      "image/gif" = [ "org.kde.gwenview.desktop" ];
      "image/webp" = [ "org.kde.gwenview.desktop" ];
      "image/tiff" = [ "org.kde.gwenview.desktop" ];
      "image/svg+xml" = [ "org.kde.gwenview.desktop" ];
      ### ARCHIVES ###
      "application/zip" = [ "org.kde.ark.desktop" ];
      "application/x-compressed-tar" = [ "org.kde.ark.desktop" ];
      "application/x-bzip-compressed-tar" = [ "org.kde.ark.desktop" ];
      "application/x-xz-compressed-tar" = [ "org.kde.ark.desktop" ];
      "application/x-rar" = [ "org.kde.ark.desktop" ];
      "application/x-7z-compressed" = [ "org.kde.ark.desktop" ];
      ### Media Player ###
      "video/mp4" = [ "mpv.desktop" ];
      "video/x-matroska" = [ "mpv.desktop" ];
      "video/webm" = [ "mpv.desktop" ];
      "audio/mpeg" = [ "mpv.desktop" ];
      "audio/ogg" = [ "mpv.desktop" ];
      "audio/wav" = [ "mpv.desktop" ];
      ### DOCUMENTS ###
      "application/msword" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.openxmlformats-officedocument.wordprocessingml.document" =
        [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.ms-excel" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet" =
        [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.ms-powerpoint" = [ "onlyoffice-desktopeditors.desktop" ];
      "application/vnd.openxmlformats-officedocument.presentationml.presentation" =
        [ "onlyoffice-desktopeditors.desktop" ];
    };
  };
}
