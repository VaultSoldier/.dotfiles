{
  inputs,
  pkgs,
  lib,
  ...
}:
let
  patchedCaelestiaShell =
    inputs.caelestia-shell.packages.${pkgs.stdenv.hostPlatform.system}.default.override
      {
        material-symbols = pkgs.material-symbols.overrideAttrs (old: {
          nativeBuildInputs = builtins.filter (x: x != pkgs.rename) old.nativeBuildInputs;
          installPhase = ''
            runHook preInstall
            install -Dm755 variablefont/*.ttf -t $out/share/fonts/TTF
            install -Dm755 variablefont/*.woff2 -t $out/share/fonts/woff2
            runHook postInstall
          '';
        });
      };
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
    package = patchedCaelestiaShell;
    systemd.enable = false;
  };

  programs.caelestia.settings = {
    mediaGifSpeedAdjustment = lib.mkDefault 300;
    sessionGifSpeed = lib.mkDefault 0.7;
    appearance = {
      anim.durations.scale = lib.mkDefault 0.8;
      font = {
        family = {
          material = lib.mkDefault "Material Symbols Rounded";
          mono = lib.mkDefault "CaskaydiaCove NF";
          sans = lib.mkDefault "Rubik";
        };
        size.scale = lib.mkDefault 1;
      };
      padding.scale = lib.mkDefault 1;
      rounding.scale = lib.mkDefault 0.6;
      spacing.scale = lib.mkDefault 0.8;
      transparency = {
        enabled = lib.mkDefault true;
        base = lib.mkDefault 0.70;
        layers = lib.mkDefault 0.2;
      };
    };

    general = {
      logo = lib.mkDefault "caelestia";
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
        timeouts = lib.mkDefault [
          {
            timeout = 600;
            idleAction = "dpms off";
            returnAction = "dpms on";
          }
          {
            timeout = 750;
            idleAction = "lock";
          }
          {
            timeout = 900;
            idleAction = [
              "systemctl"
              "suspend"
            ];
          }
        ];
      };
    };

    background = {
      enabled = lib.mkDefault true;
      wallpaperEnabled = lib.mkDefault true;
      desktopClock = {
        enabled = lib.mkDefault true;
        scale = lib.mkDefault 1.0;
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
      clock = {
        background = lib.mkDefault false;
        showDate = lib.mkDefault true;
        showIcon = lib.mkDefault true;
      };
      dragThreshold = lib.mkDefault 20;
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
      persistent = lib.mkDefault true;
      showOnHover = lib.mkDefault true;
      popouts = {
        activeWindow = lib.mkDefault false;
        statusIcons = lib.mkDefault true;
        tray = lib.mkDefault true;
      };
      scrollActions = {
        brightness = lib.mkDefault true;
        workspaces = lib.mkDefault true;
        volume = lib.mkDefault true;
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
      tray = {
        iconSubs = lib.mkDefault [ ];
        background = lib.mkDefault false;
        recolour = lib.mkDefault false;
      };
      workspaces = {
        activeIndicator = lib.mkDefault true;
        activeLabel = lib.mkDefault "󰮯";
        activeTrail = lib.mkDefault false;
        label = lib.mkDefault "";
        occupiedBg = lib.mkDefault false;
        occupiedLabel = lib.mkDefault "󰮯";
        perMonitorWorkspaces = lib.mkDefault true;
        showWindows = lib.mkDefault false;
        showWindowsOnSpecialWorkspaces = lib.mkDefault false;
        maxWindowIcons = lib.mkDefault 1;
        shown = lib.mkDefault 5;
        specialWorkspaceIcons = lib.mkDefault [
          {
            name = "notes";
            icon = "sticky_note";
          }
        ];
      };
      excludedScreens = lib.mkDefault [ "" ];
      activeWindow = {
        compact = lib.mkDefault true;
        inverted = lib.mkDefault false;
      };
    };

    border = {
      rounding = lib.mkDefault 25;
      thickness = lib.mkDefault 2;
    };

    dashboard = {
      enabled = lib.mkDefault true;
      dragThreshold = lib.mkDefault 50;
      mediaUpdateInterval = lib.mkDefault 500;
      showOnHover = lib.mkDefault true;
    };

    launcher = {
      actionPrefix = lib.mkDefault ">";
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
          enabled = true;
          dangerous = false;
        }
        {
          name = "Random";
          icon = "casino";
          description = "Switch to a random wallpaper";
          command = [
            "caelestia"
            "wallpaper"
            "-r"
          ];
          enabled = true;
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
          name = "Shutdown";
          icon = "power_settings_new";
          description = "Shutdown the system";
          command = [
            "systemctl"
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
            "systemctl"
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
            "systemctl"
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
            "controlCenter"
            "open"
          ];
          enabled = true;
          dangerous = false;
        }
      ];
      dragThreshold = lib.mkDefault 50;
      vimKeybinds = true;
      enableDangerousActions = lib.mkDefault true;
      maxShown = lib.mkDefault 8;
      maxWallpapers = lib.mkDefault 9;
      specialPrefix = lib.mkDefault "@";
      useFuzzy = {
        apps = lib.mkDefault true;
        actions = lib.mkDefault true;
        schemes = lib.mkDefault false;
        variants = lib.mkDefault false;
        wallpapers = lib.mkDefault true;
      };
      showOnHover = lib.mkDefault false;
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
    };

    lock = {
      recolourLogo = lib.mkDefault false;
      hideNotifs = lib.mkDefault true;
    };

    notifs = {
      fullscreen = lib.mkDefault "off";
      actionOnClick = lib.mkDefault false;
      clearThreshold = lib.mkDefault 0.3;
      defaultExpireTimeout = lib.mkDefault 5000;
      expandThreshold = lib.mkDefault 20;
      openExpanded = lib.mkDefault false;
      expire = lib.mkDefault true;
    };

    osd = {
      enabled = lib.mkDefault true;
      enableBrightness = lib.mkDefault true;
      enableMicrophone = lib.mkDefault false;
      hideDelay = lib.mkDefault 2000;
    };

    paths = {
      mediaGif = lib.mkDefault "~/.dotfiles/assets/nekodance.gif";
      sessionGif = lib.mkDefault "~/.dotfiles/assets/nekolay.gif";
      wallpaperDir = lib.mkDefault "~/Pictures/Wallpapers";
    };

    services = {
      audioIncrement = lib.mkDefault 0.1;
      brightnessIncrement = lib.mkDefault 0.1;
      maxVolume = lib.mkDefault 1.0;
      showLyrics = lib.mkDefault true;
      defaultPlayer = lib.mkDefault "Spotify";
      gpuType = lib.mkDefault "";
      playerAliases = lib.mkDefault [
        {
          from = "com.github.th_ch.youtube_music";
          to = "YT Music";
        }
      ];
      weatherLocation = lib.mkDefault "";
      useFahrenheit = lib.mkDefault false;
      useFahrenheitPerformance = lib.mkDefault false;
      useTwelveHourClock = lib.mkDefault false;
      smartScheme = lib.mkDefault true;
      visualiserBars = lib.mkDefault 45;
    };

    session = {
      dragThreshold = lib.mkDefault 30;
      enabled = lib.mkDefault true;
      vimKeybinds = true;
      icons = {
        logout = "logout";
        shutdow = "power_settings_new";
        hibernate = "downloading";
        reboot = "cached";
      };
      commands = {
        logout = lib.mkDefault [
          "uwsm"
          "stop"
        ];
        shutdown = lib.mkDefault [
          "systemctl"
          "poweroff"
        ];
        hibernate = lib.mkDefault [
          "systemctl"
          "hibernate"
        ];
        reboot = lib.mkDefault [
          "systemctl"
          "reboot"
        ];
      };
    };

    utilities = {
      enabled = lib.mkDefault true;
      maxToasts = lib.mkDefault 2;
      toasts = {
        fullscreen = lib.mkDefault "important";
        audioInputChanged = lib.mkDefault true;
        audioOutputChanged = lib.mkDefault true;
        capsLockChanged = lib.mkDefault true;
        chargingChanged = lib.mkDefault true;
        configLoaded = lib.mkDefault true;
        dndChanged = lib.mkDefault true;
        gameModeChanged = lib.mkDefault true;
        kbLayoutChanged = lib.mkDefault false;
        kbLimit = lib.mkDefault true;
        numLockChanged = lib.mkDefault true;
        vpnChanged = lib.mkDefault true;
        nowPlaying = lib.mkDefault false;
      };
      vpn = {
        enabled = lib.mkDefault true;
        provider = lib.mkDefault [ ];
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
            { class = "electron"; }
            { initialTitle = "obsidian"; }
          ];
          command = [ "obsidian" ];
          move = true;
        };
      };
    };
  };
}
