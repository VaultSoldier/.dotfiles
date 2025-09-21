{ config, pkgs, inputs, ... }:

{
  home.username = "vs";
  home.homeDirectory = "/home/vs";

  imports = [ ./mimeapps.nix inputs.zen-browser.homeModules.beta ];

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "25.05"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.

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

  programs.btop = {
    enable = true;
    settings = {
      color_theme = "horizon";
      theme_background = false;
      vim_keys = true;
    };
  };
  programs.git = {
    enable = true;
    userName = "VaultSoldier";
    userEmail = "61462705+VaultSoldier@users.noreply.github.com";
    extraConfig = {
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/ssh_keys/git_id_ed25519";
      pull.rebase = true;
    };
  };

  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  ~/.local/state/nix/profiles/profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/vs/etc/profile.d/hm-session-vars.sh
  #

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
