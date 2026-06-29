{
  inputs,
  config,
  pkgs,
  lib,
  ...
}:
let
  home = config.home.homeDirectory;
in
{
  imports = [ inputs.caelestia-shell.homeManagerModules.default ];

  home.packages = with pkgs; [
    hyprpicker # color picker
    hyprsunset # night mode
    playerctl
    cava # audio visualizer
    aubio # audio analysis
    bluez # bluetooth
    pavucontrol # audio control
    brightnessctl # brightness control
    cliphist # clipboard history
    wl-clipboard # clipboard support
    ddcutil
    app2unit
    file
  ];

  programs.caelestia = {
    enable = true;
    systemd.enable = false;
  };

  programs.caelestia.settings = {
    appearance = {
      deformScale = lib.mkDefault 1;
      rounding.scale = lib.mkDefault 0.6;
      spacing.scale = lib.mkDefault 0.8;
      padding.scale = lib.mkDefault 1;

      font = {
        scale = lib.mkDefault 1;
        clock = lib.mkDefault "Rubik";
        workspaces = lib.mkDefault "Rubik";

        headline.family = lib.mkDefault "GoogleSansFlex";
        headline.large.size = lib.mkDefault 32;
        headline.large.weight = lib.mkDefault 500;
        headline.large.italic = lib.mkDefault false;
        headline.large.vaxes = lib.mkDefault {
          ROND = 25;
        };

        headline.medium.size = lib.mkDefault 28;
        headline.medium.weight = lib.mkDefault 500;
        headline.medium.italic = lib.mkDefault false;
        headline.medium.vaxes = lib.mkDefault {
          ROND = 25;
        };

        headline.small.size = lib.mkDefault 24;
        headline.small.weight = lib.mkDefault 500;
        headline.small.italic = lib.mkDefault false;
        headline.small.vaxes = lib.mkDefault {
          ROND = 25;
        };

        title.family = lib.mkDefault "GoogleSansFlex";
        title.large.size = lib.mkDefault 22;
        title.large.weight = lib.mkDefault 500;
        title.large.italic = lib.mkDefault false;
        title.large.vaxes = lib.mkDefault {
          ROND = 25;
        };
        title.medium.size = lib.mkDefault 16;
        title.medium.weight = lib.mkDefault 500;
        title.medium.italic = lib.mkDefault false;
        title.medium.vaxes = lib.mkDefault {
          ROND = 25;
        };
        title.small.size = lib.mkDefault 14;
        title.small.weight = lib.mkDefault 500;
        title.small.italic = lib.mkDefault false;
        title.small.vaxes = lib.mkDefault {
          ROND = 25;
        };

        body.family = lib.mkDefault "GoogleSansFlex";
        body.large.size = lib.mkDefault 16;
        body.large.weight = lib.mkDefault 400;
        body.large.italic = lib.mkDefault false;
        body.large.vaxes = lib.mkDefault {
          ROND = 25;
        };
        body.medium.size = lib.mkDefault 14;
        body.medium.weight = lib.mkDefault 400;
        body.medium.italic = lib.mkDefault false;
        body.medium.vaxes = lib.mkDefault {
          ROND = 25;
        };
        body.small.size = lib.mkDefault 12;
        body.small.weight = lib.mkDefault 400;
        body.small.italic = lib.mkDefault false;
        body.small.vaxes = lib.mkDefault {
          ROND = 25;
        };

        label.family = lib.mkDefault "GoogleSansFlex";
        label.large.size = lib.mkDefault 14;
        label.large.weight = lib.mkDefault 500;
        label.large.italic = lib.mkDefault false;
        label.large.vaxes = lib.mkDefault {
          ROND = 25;
        };

        label.medium.size = lib.mkDefault 12;
        label.medium.weight = lib.mkDefault 500;
        label.medium.italic = lib.mkDefault false;
        label.medium.vaxes = lib.mkDefault {
          ROND = 25;
        };

        label.small.size = lib.mkDefault 11;
        label.small.weight = lib.mkDefault 400;
        label.small.italic = lib.mkDefault false;
        label.small.vaxes = lib.mkDefault {
          ROND = 25;
        };

        mono.family = lib.mkDefault "CaskaydiaCove NF";
        mono.large.size = lib.mkDefault 16;
        mono.large.weight = lib.mkDefault 400;
        mono.large.italic = lib.mkDefault false;
        mono.large.vaxes = lib.mkDefault { };

        mono.medium.size = lib.mkDefault 14;
        mono.medium.weight = lib.mkDefault 400;
        mono.medium.italic = lib.mkDefault false;
        mono.medium.vaxes = lib.mkDefault { };

        mono.small.size = lib.mkDefault 12;
        mono.small.weight = lib.mkDefault 400;
        mono.small.italic = lib.mkDefault false;
        mono.small.vaxes = lib.mkDefault { };

        icon.family = lib.mkDefault "Material Symbols Rounded";
        icon.extraLarge.size = lib.mkDefault 36;
        icon.extraLarge.weight = lib.mkDefault 400;
        icon.extraLarge.italic = lib.mkDefault false;
        icon.extraLarge.vaxes = lib.mkDefault { };

        icon.large.size = lib.mkDefault 24;
        icon.large.weight = lib.mkDefault 400;
        icon.large.italic = lib.mkDefault false;
        icon.large.vaxes = lib.mkDefault { };

        icon.medium.size = lib.mkDefault 18;
        icon.medium.weight = lib.mkDefault 400;
        icon.medium.italic = lib.mkDefault false;
        icon.medium.vaxes = lib.mkDefault { };

        icon.small.size = lib.mkDefault 15;
        icon.small.weight = lib.mkDefault 400;
        icon.small.italic = lib.mkDefault false;
        icon.small.vaxes = lib.mkDefault { };
      };

      anim = {
        durations.scale = lib.mkDefault 0.8;
      };
      transparency = {
        enabled = lib.mkDefault true;
        base = lib.mkDefault 0.70;
        layers = lib.mkDefault 0.2;
      };
    };

    general = {
      logo = lib.mkDefault "caelestia";
      showOverFullscreen = lib.mkDefault false;
      mediaGifSpeedAdjustment = lib.mkDefault 300;
      sessionGifSpeed = lib.mkDefault 0.7;
      apps = {
        terminal = lib.mkDefault [ "kitty" ];
        audio = lib.mkDefault [ "pavucontrol" ];
        explorer = lib.mkDefault [ "dolphin" ];
        playback = lib.mkDefault [ "mpv" ];
      };
      battery = {
        warnLevels = lib.mkDefault [
          {
            level = 20;
            title = "Low battery";
            message = "You might want to plug in a charger";
            icon = "battery_android_frame_2";
          }
          {
            level = 10;
            title = "Did you see the previous message?";
            message = "You should probably plug in a charger <b>now</b>";
            icon = "battery_android_frame_1";
          }
          {
            level = 5;
            title = "Critical battery level";
            message = "PLUG THE CHARGER RIGHT NOW!!";
            icon = "battery_android_alert";
            critical = true;
          }
        ];
        criticalLevel = lib.mkDefault 3;
      };
      idle = {
        lockBeforeSleep = lib.mkDefault true;
        inhibitWhenAudio = lib.mkDefault true;
        inhibitWhenCharging = lib.mkDefault false;
        timeouts = lib.mkDefault [
          {
            timeout = 600;
            idleAction = "dpms off";
            returnAction = "dpms on";
          }
          {
            timeout = 750;
            idleAction = "lock";
            inhibitWhenAudio = false;
            inhibitWhenCharging = false;
            respectInhibitors = true;
          }
          {
            timeout = 900;
            idleAction = [
              "suspend"
            ];
          }
        ];
      };
    };

    background = {
      enabled = lib.mkDefault true;
      wallpaperEnabled = lib.mkDefault false;
      desktopClock = {
        enabled = lib.mkDefault true;
        scale = lib.mkDefault 1;
        position = lib.mkDefault "bottom-right";
        shadow = {
          enabled = lib.mkDefault true;
          opacity = lib.mkDefault 0.7;
          blur = lib.mkDefault 0.4;
        };
        background = {
          enabled = lib.mkDefault false;
          opacity = lib.mkDefault 0.7;
          blur = lib.mkDefault true;
        };
        invertColors = lib.mkDefault false;
      };
      visualiser = {
        enabled = lib.mkDefault false;
        blur = lib.mkDefault false;
        autoHide = lib.mkDefault true;
        rounding = lib.mkDefault 0.5;
        spacing = lib.mkDefault 1;
      };
    };

    bar = {
      persistent = lib.mkDefault true;
      showOnHover = lib.mkDefault true;
      dragThreshold = lib.mkDefault 20;
      scrollActions = {
        brightness = lib.mkDefault true;
        workspaces = lib.mkDefault true;
        volume = lib.mkDefault true;
      };
      popouts = {
        activeWindow = lib.mkDefault false;
        statusIcons = lib.mkDefault true;
        tray = lib.mkDefault true;
      };
      workspaces = {
        shown = lib.mkDefault 5;
        activeIndicator = lib.mkDefault true;
        occupiedBg = lib.mkDefault false;
        showWindows = lib.mkDefault false;
        showWindowsOnSpecialWorkspaces = lib.mkDefault false;
        maxWindowIcons = lib.mkDefault 1;
        activeTrail = lib.mkDefault false;
        activeLabel = lib.mkDefault "󰮯";
        label = lib.mkDefault "";
        occupiedLabel = lib.mkDefault "󰮯";
        perMonitorWorkspaces = lib.mkDefault true;
        specialWorkspaceIcons = lib.mkDefault [
          {
            name = "notes";
            icon = "sticky_note";
          }
        ];
      };
      activeWindow = {
        compact = lib.mkDefault true;
        inverted = lib.mkDefault false;
        showOnHover = lib.mkDefault true;
      };
      tray = {
        background = lib.mkDefault false;
        recolour = lib.mkDefault false;
        compact = lib.mkDefault false;
        iconSubs = lib.mkDefault [ ];
        hiddenIcons = lib.mkDefault [ ];
      };
      status = {
        showAudio = lib.mkDefault true;
        showBattery = lib.mkDefault false;
        showBluetooth = lib.mkDefault true;
        showKbLayout = lib.mkDefault true;
        showMicrophone = lib.mkDefault false;
        showNetwork = lib.mkDefault true;
        showWifi = lib.mkDefault false;
        showLockStatus = lib.mkDefault false;
      };
      clock = {
        background = lib.mkDefault false;
        showDate = lib.mkDefault true;
        showIcon = lib.mkDefault true;
      };
      entries = lib.mkDefault [
        {
          id = "logo";
          enabled = true;
        }
        {
          id = "workspaces";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "activeWindow";
          enabled = true;
        }
        {
          id = "spacer";
          enabled = true;
        }
        {
          id = "tray";
          enabled = true;
        }
        {
          id = "clock";
          enabled = true;
        }
        {
          id = "statusIcons";
          enabled = true;
        }
        {
          id = "power";
          enabled = true;
        }
      ];
      excludedScreens = lib.mkDefault [ "" ];
    };
    border = {
      thickness = lib.mkDefault 2;
      rounding = lib.mkDefault 25;
      smoothing = lib.mkDefault 20;
    };
    dashboard = {
      enabled = lib.mkDefault true;
      showOnHover = lib.mkDefault true;
      showDashboard = lib.mkDefault true;
      showMedia = lib.mkDefault true;
      showPerformance = lib.mkDefault true;
      showWeather = lib.mkDefault true;
      mediaUpdateInterval = lib.mkDefault 500;
      resourceUpdateInterval = lib.mkDefault 1000;
      dragThreshold = lib.mkDefault 50;
      performance = {
        showBattery = lib.mkDefault true;
        showGpu = lib.mkDefault true;
        showCpu = lib.mkDefault true;
        showMemory = lib.mkDefault true;
        showStorage = lib.mkDefault true;
        showNetwork = lib.mkDefault true;
      };
    };
    launcher = {
      enabled = lib.mkDefault true;
      showOnHover = lib.mkDefault false;
      maxShown = lib.mkDefault 8;
      maxWallpapers = lib.mkDefault 9;
      specialPrefix = lib.mkDefault "@";
      actionPrefix = lib.mkDefault ">";
      enableDangerousActions = lib.mkDefault true;
      dragThreshold = lib.mkDefault 50;
      vimKeybinds = lib.mkDefault true;
      favouriteApps = lib.mkDefault [ ];
      hiddenApps = lib.mkDefault [
        "nvidia-settings"
        "org.kde.konsole"
        "org.kde.kwikdisk"
        "org.kde.kdf"
        "menu-editor"
        "qt5ct"
        "qt6ct"
        "uuctl"
        "htop"
        "btop"
        "nvim"
      ];
      useFuzzy = {
        apps = lib.mkDefault true;
        actions = lib.mkDefault true;
        schemes = lib.mkDefault false;
        variants = lib.mkDefault false;
        wallpapers = lib.mkDefault false;
      };
      actions = lib.mkDefault [
        {
          name = "Calculator";
          icon = "calculate";
          description = "Do simple math equations (powered by Qalc)";
          command = [
            "autocomplete"
            "calc"
          ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Scheme";
          icon = "palette";
          description = "Change the current colour scheme";
          command = [
            "autocomplete"
            "scheme"
          ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Wallpaper";
          icon = "image";
          description = "Change the current wallpaper";
          command = [
            "autocomplete"
            "wallpaper"
          ];
          enabled = false;
          dangerous = false;
        }
        {
          name = "Variant";
          icon = "colors";
          description = "Change the current scheme variant";
          command = [
            "autocomplete"
            "variant"
          ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Random";
          icon = "casino";
          description = "Switch to a random wallpaper";
          command = [
            "${home}/.config/hypr/scripts/awww_randomize.sh"
            "--once"
            "${home}/Pictures/Wallpapers"
          ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Shutdown";
          icon = "power_settings_new";
          description = "Shutdown the system";
          command = [
            "poweroff"
          ];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Reboot";
          icon = "cached";
          description = "Reboot the system";
          command = [
            "reboot"
          ];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Logout";
          icon = "exit_to_app";
          description = "Log out of the current session";
          command = [
            "uwsm"
            "stop"
          ];
          enabled = true;
          dangerous = true;
        }
        {
          name = "Lock";
          icon = "lock";
          description = "Lock the current session";
          command = [
            "loginctl"
            "lock-session"
          ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Sleep";
          icon = "bedtime";
          description = "Suspend";
          command = [
            "suspend"
          ];
          enabled = true;
          dangerous = false;
        }
        {
          name = "Settings";
          icon = "settings";
          description = "Configure the shell";
          command = [
            "caelestia"
            "shell"
            "nexus"
            "open"
          ];
          enabled = true;
          dangerous = false;
        }
      ];
    };
    lock = {
      enabled = lib.mkDefault true;
      recolourLogo = lib.mkDefault true;
      enableFprint = lib.mkDefault false;
      maxFprintTries = lib.mkDefault 6;
      hideNotifs = lib.mkDefault true;
    };
    nexus = {
      wallpapersPerRow = lib.mkDefault 4;
      networkRescanInterval = lib.mkDefault 15000;
    };
    notifs = {
      expire = lib.mkDefault true;
      fullscreen = lib.mkDefault "off";
      defaultExpireTimeout = lib.mkDefault 5000;
      fullscreenExpireTimeout = lib.mkDefault 2000;
      clearThreshold = lib.mkDefault 0.3;
      expandThreshold = lib.mkDefault 20;
      actionOnClick = lib.mkDefault false;
      groupPreviewNum = lib.mkDefault 3;
      openExpanded = lib.mkDefault false;
    };
    osd = {
      enabled = lib.mkDefault true;
      enableBrightness = lib.mkDefault true;
      enableMicrophone = lib.mkDefault false;
      hideDelay = lib.mkDefault 2000;
    };
    services = {
      weatherLocation = lib.mkDefault "";
      useFahrenheit = lib.mkDefault false;
      useFahrenheitPerformance = lib.mkDefault false;
      useTwelveHourClock = lib.mkDefault false;
      gpuType = lib.mkDefault "";
      visualiserBars = lib.mkDefault 45;
      audioIncrement = lib.mkDefault 0.1;
      brightnessIncrement = lib.mkDefault 0.1;
      maxVolume = lib.mkDefault 1;
      smartScheme = lib.mkDefault true;
      lyricsBackend = lib.mkDefault "Auto";
      defaultPlayer = lib.mkDefault "Spotify";
      playerAliases = lib.mkDefault [
        {
          from = "com.github.th_ch.youtube_music";
          to = "YT Music";
        }
      ];
    };
    session = {
      enabled = lib.mkDefault true;
      dragThreshold = lib.mkDefault 30;
      vimKeybinds = lib.mkDefault true;
      icons = {
        logout = "logout";
        shutdown = "power_settings_new";
        hibernate = "downloading";
        reboot = "cached";
      };
      commands = {
        logout = lib.mkDefault [
          "uwsm"
          "stop"
        ];
        shutdown = lib.mkDefault [
          "poweroff"
        ];
        hibernate = lib.mkDefault [
          "hibernate"
        ];
        reboot = lib.mkDefault [
          "reboot"
        ];
      };
    };
    sidebar = {
      enabled = lib.mkDefault true;
      showOnHover = lib.mkDefault false;
      minHoverThreshold = lib.mkDefault 200;
      dragThreshold = lib.mkDefault 80;
    };
    utilities = {
      enabled = lib.mkDefault true;
      maxToasts = lib.mkDefault 2;
      toasts = {
        fullscreen = lib.mkDefault "important";
        configLoaded = lib.mkDefault true;
        chargingChanged = lib.mkDefault true;
        gameModeChanged = lib.mkDefault true;
        dndChanged = lib.mkDefault true;
        audioOutputChanged = lib.mkDefault true;
        audioInputChanged = lib.mkDefault true;
        capsLockChanged = lib.mkDefault true;
        numLockChanged = lib.mkDefault true;
        kbLayoutChanged = lib.mkDefault false;
        kbLimit = lib.mkDefault true;
        vpnChanged = lib.mkDefault true;
        nowPlaying = lib.mkDefault false;
      };
      vpn = {
        enabled = lib.mkDefault true;
        provider = lib.mkDefault [
          {
            name = "wireguard";
            interface = "exit-home-nolan";
            displayName = "WG (ExitNode-HomeNoLan)";
            enabled = true;
            connectCmd = [
              "sudo"
              "systemctl"
              "start"
              "wg-quick-exit-home-nolan"
            ];
            disconnectCmd = [
              "sudo"
              "systemctl"
              "stop"
              "wg-quick-exit-home-nolan"
            ];
          }
          {
            name = "wireguard";
            interface = "exit-home";
            displayName = "WG (ExitNode-Home)";
            enabled = false;
            connectCmd = [
              "sudo"
              "systemctl"
              "start"
              "wg-quick-exit-home"
            ];
            disconnectCmd = [
              "sudo"
              "systemctl"
              "stop"
              "wg-quick-exit-home"
            ];
          }
          {
            name = "wireguard";
            interface = "split-home";
            displayName = "WG (Split-Home)";
            enabled = false;
            connectCmd = [
              "sudo"
              "systemctl"
              "start"
              "wg-quick-split-home"
            ];
            disconnectCmd = [
              "sudo"
              "systemctl"
              "stop"
              "wg-quick-split-home"
            ];
          }

        ];
      };
      quickToggles = lib.mkDefault [
        {
          id = "wifi";
          enabled = true;
        }
        {
          id = "bluetooth";
          enabled = true;
        }
        {
          id = "mic";
          enabled = true;
        }
        {
          id = "settings";
          enabled = true;
        }
        {
          id = "gameMode";
          enabled = true;
        }
        {
          id = "dnd";
          enabled = true;
        }
        {
          id = "vpn";
          enabled = true;
        }
      ];
    };
    paths = {
      mediaGif = lib.mkDefault "~/.dotfiles/assets/nekodance.gif";
      sessionGif = lib.mkDefault "~/.dotfiles/assets/nekolay.gif";
      noNotifsPic = lib.mkDefault "root:/assets/dino.png";
      lockNoNotifsPic = lib.mkDefault "root:/assets/dino.png";
      wallpaperDir = lib.mkDefault "~/Pictures/Wallpapers";
      lyricsDir = lib.mkDefault "~/Music/lyrics";
    };
  };

  programs.caelestia.cli = {
    enable = true;
    settings = {
      record.extraArgs = lib.mkDefault [ ];
      theme = {
        enableTerm = false;
        enableHypr = false;
        enableDiscord = false;
        enableSpicetify = false;
        enableFuzzel = false;
        enableBtop = false;
        enableGtk = false;
        enableQt = false;
      };
      toggles = {
        communication = {
          discord = {
            enable = true;
            match = [ { class = "vesktop"; } ];
            move = true;
          };
          telegram = {
            enable = true;
            match = [ { class = "telegram"; } ];
            move = true;
          };
          nextcloud-talk = {
            enable = true;
            match = [ { class = "Nextcloud Talk"; } ];
            move = true;
          };
        };
        music.spotify = {
          enable = true;
          match = [
            { class = "Spotify"; }
            { initialTitle = "Spotify"; }
            { initialTitle = "Spotify Free"; }
          ];
          command = [ "spotify" ];
          move = true;
        };
        sysmon.btop = {
          enable = true;
          match = [
            {
              class = "btop";
              title = "btop";
              workspace.name = "special:sysmon";
            }
          ];
          command = [
            "kitty"
            "--class"
            "btop"
            "--title"
            "btop"
            "zsh"
            "-c"
            "exec btop"
          ];
        };
        notes.obsidian = {
          enable = true;
          match = [
            { class = "obsidian"; }
          ];
          command = [ "obsidian" ];
          move = true;
        };
      };
    };
  };
}
