{ ... }:
{
  services.syncthing = {
    enable = true;
    openDefaultPorts = true;
    dataDir = "/home/vs";
    user = "vs";
    group = "users";
    guiAddress = "127.0.0.1:8384";
    guiPasswordFile = "/run/secrets/syncthing_gui_pass";

    settings.options = {
      localAnnounceEnabled = true;
      relaysEnabled = false;
      globalAnnounceEnabled = false;
      urAccepted = -1;
    };

    settings.devices = {
      laptop.name = "laptop";
      laptop.id = "WPPJDMY-DHKNHLR-ZU5ZNGV-FSVEX2M-F3Y5UGL-EMNXNHA-QXS7VFZ-PCODEAR";

      work.name = "work";
      work.id = "VQ7YMTT-ZK226P4-HGYX4W5-ZRF4ZVO-OFRM7F5-Y3ZSLQC-DVMNYYW-46HCUA5";
    };

    settings.folders = {
      documents = {
        path = "~/Documents/DocSync";
        ignorePatterns = [
          ".venv"
          "__pycache__"
        ];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
            cleanoutDays = "0";
          };
        };
        devices = [
          "laptop"
          "work"
        ];
      };
      code = {
        path = "~/Documents/Code";
        ignorePatterns = [
          ".venv"
          "__pycache__"
        ];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
            cleanoutDays = "0";
          };
        };
        devices = [
          "laptop"
          "work"
        ];
      };
      obsidian_vault = {
        path = "~/Documents/Obsidian Vault";
        versioning = {
          type = "simple";
          params = {
            keep = "10";
            cleanoutDays = "0";
          };
        };
        devices = [
          "laptop"
          "work"
        ];
      };
      wallpapers = {
        path = "~/Pictures/Wallpapers";
        versioning = {
          type = "simple";
          params = {
            keep = "10";
            cleanoutDays = "0";
          };
        };
        devices = [
          "laptop"
          "work"
        ];
      };
      winbox_addresses = {
        path = "~/.local/share/MikroTik/WinBox";
        ignorePatterns = [
          "**"
          "!Addresses.cdb"
        ];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
            cleanoutDays = "0";
          };
        };
        devices = [
          "laptop"
          "work"
        ];
      };
    };
  };
}
