{ inputs, pkgs, ... }:
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

    settings = {
      mediaGifSpeedAdjustment = 300;
      sessionGifSpeed = 0.7;
      appearance = {
        anim.durations.scale = 0.8;
        font = {
          family = {
            material = "Material Symbols Sharp";
            mono = "CaskaydiaCove NF";
            sans = "Rubik";
          };
          size.scale = 1;
        };
        padding.scale = 1;
        rounding.scale = 0.6;
        spacing.scale = 0.8;
        transparency = {
          enabled = false;
          base = 0.85;
          layers = 0.4;
        };
      };

      general = {
        apps = {
          terminal = [ "kitty" ];
          audio = [ "pavucontrol" ];
          explorer = [ "dolphin" ];
          playback = [ "mpv" ];
        };
        battery = {
          warnLevels = [
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
          criticalLevel = 3;
        };
        idle = {
          lockBeforeSleep = true;
          inhibitWhenAudio = true;
          timeouts = [
            {
              timeout = 650;
              idleAction = "lock";
            }
            {
              timeout = 300;
              idleAction = "dpms off";
              returnAction = "dpms on";
            }
            {
              timeout = 1000;
              idleAction = [
                "systemctl"
                "suspend"
              ];
            }
          ];
        };
      };

      background = {
        enabled = true;
        wallpaperEnabled = true;
        desktopClock = {
          enabled = false;
          scale = 1.0;
          position = "bottom-right";
          shadow = {
            enabled = true;
            opacity = 0.7;
            blur = 0.4;
          };
          background = {
            enabled = false;
            opacity = 0.7;
            blur = true;
          };
          invertColors = false;
        };
        visualiser = {
          enabled = false;
          blur = false;
          autoHide = true;
          rounding = 0.5;
          spacing = 1;
        };
      };

      bar = {
        clock.showIcon = true;
        dragThreshold = 20;
        entries = [
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
        persistent = true;
        popouts = {
          activeWindow = false;
          statusIcons = true;
          tray = true;
        };
        scrollActions = {
          brightness = true;
          workspaces = true;
          volume = true;
        };
        showOnHover = true;
        status = {
          showAudio = true;
          showBattery = false;
          showBluetooth = true;
          showKbLayout = true;
          showMicrophone = false;
          showNetwork = true;
          showWifi = false;
          showLockStatus = true;
        };
        tray = {
          background = false;
          iconSubs = [ ];
          recolour = false;
        };
        workspaces = {
          activeIndicator = true;
          activeLabel = "󰮯";
          activeTrail = false;
          label = "  ";
          occupiedBg = false;
          occupiedLabel = "󰮯";
          perMonitorWorkspaces = true;
          showWindows = true;
          shown = 5;
          specialWorkspaceIcons = [
            {
              name = "notes";
              icon = "sticky_note";
            }
          ];
        };
        excludedScreens = [ "" ];
        activeWindow = {
          inverted = false;
        };
      };
      border = {
        rounding = 25;
        thickness = 2;
      };
      dashboard = {
        enabled = true;
        dragThreshold = 50;
        mediaUpdateInterval = 500;
        showOnHover = true;
      };
      launcher = {
        actionPrefix = ">";
        actions = [
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
            name = "Light";
            icon = "light_mode";
            description = "Change the scheme to light mode";
            command = [
              "setMode"
              "light"
            ];
            enabled = true;
            dangerous = false;
          }
          {
            name = "Dark";
            icon = "dark_mode";
            description = "Change the scheme to dark mode";
            command = [
              "setMode"
              "dark"
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
        dragThreshold = 50;
        vimKeybinds = true;
        enableDangerousActions = true;
        maxShown = 8;
        maxWallpapers = 9;
        specialPrefix = "@";
        useFuzzy = {
          apps = true;
          actions = false;
          schemes = false;
          variants = false;
          wallpapers = false;
        };
        showOnHover = false;
        hiddenApps = [
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

      lock.recolourLogo = false;

      notifs = {
        actionOnClick = false;
        clearThreshold = 0.3;
        defaultExpireTimeout = 5000;
        expandThreshold = 20;
        openExpanded = false;
        expire = true;
      };

      osd = {
        enabled = true;
        enableBrightness = true;
        enableMicrophone = true;
        hideDelay = 2000;
      };

      paths = {
        mediaGif = "~/.dotfiles/assets/nekodance.gif";
        sessionGif = "~/.dotfiles/assets/nekolay.gif";
        wallpaperDir = "~/Pictures/NCSync/Wallpapers";
      };

      services = {
        audioIncrement = 0.1;
        brightnessIncrement = 0.1;
        maxVolume = 1.0;
        defaultPlayer = "Spotify";
        gpuType = "";
        playerAliases = [
          {
            from = "com.github.th_ch.youtube_music";
            to = "YT Music";
          }
        ];
        weatherLocation = "Chelyabinsk";
        useFahrenheit = false;
        useFahrenheitPerformance = false;
        useTwelveHourClock = false;
        smartScheme = true;
        visualiserBars = 45;
      };

      session = {
        dragThreshold = 30;
        enabled = true;
        vimKeybinds = true;
        icons = {
          logout = "logout";
          shutdow = "power_settings_new";
          hibernate = "downloading";
          reboot = "cached";
        };
        commands = {
          logout = [
            "uwsm"
            "stop"
          ];
          shutdown = [
            "systemctl"
            "poweroff"
          ];
          hibernate = [
            "systemctl"
            "hibernate"
          ];
          reboot = [
            "systemctl"
            "reboot"
          ];
        };
      };

      utilities = {
        enabled = true;
        maxToasts = 3;
        toasts = {
          audioInputChanged = true;
          audioOutputChanged = true;
          capsLockChanged = true;
          chargingChanged = true;
          configLoaded = true;
          dndChanged = true;
          gameModeChanged = true;
          kbLayoutChanged = false;
          kbLimit = true;
          numLockChanged = true;
          vpnChanged = true;
          nowPlaying = false;
          nighLight = true;
        };
        vpn = {
          enabled = false;
          provider = [
            {
              name = "wireguard";
              interface = "wg0";
              displayName = "Wireguard (Your VPN)";
              enabled = false;
            }
          ];
        };
        nightLight = {
          enabled = true;
          temperature = 4500;
        };
      };
    };
    cli = {
      enable = true; # Adds caelestia-cli to path
      settings = {
        record = {
          extraArgs = [ ];
        };
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
              command = [ "telegram" ];
              move = true;
            };
          };
          music = {
            spotify = {
              enable = true;
              match = [
                { class = "Spotify"; }
                { initialTitle = "Spotify"; }
                { initialTitle = "Spotify Free"; }
              ];
              command = [ "spotify" ];
              move = true;
            };
          };
          sysmon = {
            btop = {
              enable = true;
              match = [
                {
                  class = "btop";
                  title = "btop";
                  workspace = {
                    name = "special:sysmon";
                  };
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
          };
          notes = {
            obsidian = {
              enable = true;
              match = [ { class = "obsidian"; } ];
              command = [
                "app2unit"
                "obsidian"
              ];
              move = true;
            };
          };
        };
      };
    };
  };
}
