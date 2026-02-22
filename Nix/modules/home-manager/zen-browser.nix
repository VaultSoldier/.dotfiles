{
  inputs,
  config,
  pkgs,
  ...
}:
{
  imports = [ inputs.zen-browser.homeModules.twilight ];

  programs.zen-browser.enable = true;
  programs.zen-browser.profiles."default" = {
    containersForce = true;
    spacesForce = true;
    containers = {
      Space = {
        color = "purple";
        icon = "fingerprint";
        id = 1;
      };
      Coding = {
        color = "blue";
        icon = "circle";
        id = 2;
      };
      Homelab = {
        color = "yellow";
        icon = "chill";
        id = 3;
      };
      Work = {
        color = "green";
        icon = "briefcase";
        id = 4;
      };
    };
    spaces =
      let
        containers = config.programs.zen-browser.profiles."default".containers;
      in
      {
        "Space" = {
          id = "8c7b765f-f42f-4270-b25b-a2d695d59551";
          icon = "⭐️";
          container = containers."Space".id;
          position = 1000;
        };
        "Coding" = {
          id = "0e403e6a-c3b4-4c84-9c94-3e3367f6e213";
          icon = "📀";
          container = containers."Coding".id;
          position = 2000;
        };
        "Homelab" = {
          id = "eee83e86-c339-40e6-b6a4-38ac9e8b9a1e";
          icon = "🖥️";
          container = containers."Homelab".id;
          position = 3000;
        };
        "Work" = {
          id = "97c2167f-8670-407c-a36a-f18ed3d225cc";
          icon = "💼";
          container = containers."Work".id;
          position = 4000;
        };
      };

    # WARN: Fails activation on schema changes to detect potential regressions
    # Find this in about:config or prefs.js of your profile
    keyboardShortcutsVersion = 16;

    # INFO: Finding Shortcut IDs
    # jq -c '.shortcuts[] | {id, key, keycode, action}' ~/.config/zen/default/zen-keyboard-shortcuts.json | fzf
    keyboardShortcuts = [
      {
        id = "zen-compact-mode-toggle";
        modifiers.accel = true;
        key = "s";
      }
      {
        id = "zen-workspace-switch-1";
        modifiers = {
          accel = true;
        };
        key = "1";
      }
      {
        id = "zen-workspace-switch-2";
        modifiers.accel = true;
        key = "2";
      }
      {
        id = "zen-workspace-switch-3";
        modifiers.accel = true;
        key = "3";
      }
      {
        id = "zen-workspace-switch-4";
        modifiers.accel = true;
        key = "4";
      }
      {
        id = "zen-workspace-switch-5";
        modifiers.accel = true;
        key = "5";
      }
      {
        id = "zen-workspace-switch-6";
        modifiers.accel = true;
        key = "6";
      }
      {
        id = "addBookmarkAsKb";
        disabled = true;
      }
    ];

    mods = [
      "ea1a5ace-f698-4b45-ab88-6e8bd3a563f0" # Bookmark Toolbar Tweaks
      "a6335949-4465-4b71-926c-4a52d34bc9c0" # Better Find Bar
      "32aca67a-ffdd-49e7-95c7-1821793610ca" # Custom Statusbar
    ];
    extensions.packages = with inputs.firefox-addons.packages.${pkgs.stdenv.hostPlatform.system}; [
      bitwarden
      ublock-origin
      ublacklist
      sponsorblock
      canvasblocker
      clearurls
      spoof-timezone
      github-file-icons
      search-by-image
    ];
  };

  programs.zen-browser.policies = {
    PictureInPicture = {
      Value = true;
      Locked = true;
    };
    AutofillAddressEnabled = true;
    AutofillCreditCardEnabled = false;
    DisableAppUpdate = true;
    ExtensionUpdate = true;
    DisableFeedbackCommands = true;
    DisableFirefoxStudies = true;
    DisablePocket = true;
    DisableTelemetry = true;
    DontCheckDefaultBrowser = true;
    NoDefaultBookmarks = true;
    OfferToSaveLogins = false;
    EnableTrackingProtection = {
      Value = true;
      Locked = true;
      Cryptomining = true;
      Fingerprinting = true;
    };
  };
  programs.zen-browser.policies.Preferences = {
    "media.videocontrols.picture-in-picture.enable-when-switching-tabs.enabled" = true;
    "widget.use-xdg-desktop-portal.file-picker" = 1;
    "widget.disable-swipe-tracker" = true;
    "browser.uidensity" = 1;
    "browser.tabs.warnOnClose" = false;
    "browser.tabs.inTitlebar" = 0;
  };
  programs.zen-browser.policies.SearchEngines = {
    PreventInstalls = true; # disallow adding new engines
    Default = "DuckDuckGo";
    Remove = [
      "Bing"
      "Ecosia"
      "Google"
    ];
    Add = [
      {
        Name = "Startpage";
        URLTemplate = "https://www.startpage.com/sp/search?q={searchTerms}";
        IconURL = "https://www.startpage.com/favicon.ico";
        Alias = "@sp";
      }
      {
        Name = "Arch Wiki";
        URLTemplate = "https://wiki.archlinux.org/index.php?search={searchTerms}";
        IconURL = "https://wiki.archlinux.org/favicon.ico";
        Alias = "@arch";
      }
      {
        Name = "NixOS Packages";
        URLTemplate = "https://search.nixos.org/packages?query={searchTerms}";
        IconURL = "https://nixos.org/favicon.ico";
        Alias = "@nx";
      }
      {
        Name = "NixOS Options";
        URLTemplate = "https://search.nixos.org/options?query={searchTerms}";
        IconURL = "https://nixos.org/favicon.ico";
        Alias = "@nxo";
      }
    ];
  };
}
