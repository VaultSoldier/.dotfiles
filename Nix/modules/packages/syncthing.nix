{ pkgs, ... }:
let
  all_devices = [
    "server"
    "desktop"
    "laptop"
    "agentsmith"
  ];
in
{
  environment.systemPackages = with pkgs; [
    syncthingtray
  ];

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
      server = {
        name = "server";
        id = "QVNM4XW-CQAMBSL-HZAWZC3-A5LQSVE-FAFX3OA-WXGRUI6-X63YCIZ-NDCQTQN";
        addresses = [ "tcp://192.168.11.150:22000" ];
      };

      desktop = {
        name = "desktop";
        id = "TCHIGUY-RPIUII5-WBANBMS-KD4PKU4-V77TR37-3BQKPSM-7CTRZRS-DKVU2QF";
      };

      laptop = {
        name = "laptop";
        id = "WPPJDMY-DHKNHLR-ZU5ZNGV-FSVEX2M-F3Y5UGL-EMNXNHA-QXS7VFZ-PCODEAR";
      };

      agentsmith = {
        name = "agentsmith";
        id = "VQ7YMTT-ZK226P4-HGYX4W5-ZRF4ZVO-OFRM7F5-Y3ZSLQC-DVMNYYW-46HCUA5";
      };
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
        devices = all_devices;
      };
      projects = {
        path = "~/Projects/";
        ignorePatterns = [
          ".venv"
          "__pycache__"
          "node_modules"
          "build"
          "out"
          ".pytest_cache"
          ".idea"
          ".vscode"
          "*.pyc"
          ".DS_Store"
        ];
        versioning = {
          type = "staggered";
          params = {
            maxAge = "5356800";
          };
        };
        devices = all_devices;
      };
      obsidian_vault = {
        path = "~/Documents/Obsidian Vault";
        versioning = {
          type = "staggered";
          params = {
            maxAge = "2764800";
          };
        };
        devices = [
          "server"
          "laptop"
          "agentsmith"
        ];
      };
      wallpapers = {
        path = "~/Pictures/Wallpapers";
        devices = all_devices;
      };
      ssh = {
        path = "~/.ssh";
        ignorePatterns = [
          "!*.pub"
          "!allowed_signers"
          "!config*"
          "**"
        ];
        versioning = {
          type = "staggered";
          params = {
            maxAge = "2764800";
          };
        };
        devices = all_devices;
      };
      winbox_addresses = {
        path = "~/.local/share/MikroTik/WinBox";
        ignorePatterns = [
          "!Addresses.cdb"
          "**"
        ];
        versioning = {
          type = "staggered";
          params = {
            maxAge = "2764800";
          };
        };
        devices = all_devices;
      };
    };
  };
}
