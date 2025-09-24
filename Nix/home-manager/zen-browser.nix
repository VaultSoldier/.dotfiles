{ config, ... }: {
  programs.zen-browser = {
    enable = true;
    profiles."default" = {
      containersForce = true;
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
      spacesForce = true;
      spaces = let
        containers = config.programs.zen-browser.profiles."default".containers;
      in {
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
    };

    policies = {
      SearchEngines = {
        Default = "DuckDuckGo";
        PreventInstalls = true; # disallow adding new engines
        Remove = [ "Bing" "Ecosia" "Google" ];
        Add = [
          {
            Name = "Startpage";
            URLTemplate = "https://www.startpage.com/sp/search?q={searchTerms}";
            Method = "GET";
            IconURL = "https://www.startpage.com/favicon.ico";
            Alias = "@sp";
          }
          {
            Name = "Arch Wiki";
            URLTemplate =
              "https://wiki.archlinux.org/index.php?search={searchTerms}";
            Method = "GET";
            IconURL = "https://wiki.archlinux.org/favicon.ico";
            Alias = "@arch";
          }
          {
            Name = "NixOS Packages";
            URLTemplate =
              "https://search.nixos.org/packages?query={searchTerms}";
            Method = "GET";
            IconURL = "https://nixos.org/favicon.ico";
            Alias = "@nix";
          }
        ];
      };
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
      ExtensionSettings = {
        "uBlock0@raymondhill.net" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/file/4573289/ublock_origin-1.66.0.xpi";
          installation_mode = "force_installed";
        };
        "sponsorBlocker@ajay.app" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/file/4541835/sponsorblock-5.14.xpi";
          installation_mode = "force_installed";
        };
        "{446900e4-71c2-419f-a6a7-df9c091e268b}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/file/4567044/bitwarden_password_manager-2025.8.2.xpi";
          installation_mode = "force_installed";
        };
        "{85860b32-02a8-431a-b2b1-40fbd64c9c69}" = {
          install_url =
            "https://addons.mozilla.org/firefox/downloads/file/4238111/github_file_icons-1.5.2.xpi";
          installation_mode = "force_installed";
        };
      };
      Preferences = {
        "browser.tabs.warnOnClose" = false;
        "browser.tabs.inTitlebar" = 0;
        "widget.use-xdg-desktop-portal.file-picker" = 1;
      };
    };
  };
}
