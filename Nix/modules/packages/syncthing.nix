{ pkgs, ... }:
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
      server.name = "server";
      server.id = "QVNM4XW-CQAMBSL-HZAWZC3-A5LQSVE-FAFX3OA-WXGRUI6-X63YCIZ-NDCQTQN";
      server.addresses = [ "tcp://192.168.11.150:22000" ];

      laptop.name = "laptop";
      laptop.id = "WPPJDMY-DHKNHLR-ZU5ZNGV-FSVEX2M-F3Y5UGL-EMNXNHA-QXS7VFZ-PCODEAR";

      agentsmith.name = "agentsmith";
      agentsmith.id = "VQ7YMTT-ZK226P4-HGYX4W5-ZRF4ZVO-OFRM7F5-Y3ZSLQC-DVMNYYW-46HCUA5";
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
          "server"
          "laptop"
          "agentsmith"
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
          "server"
          "laptop"
          "agentsmith"
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
          "server"
          "laptop"
          "agentsmith"
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
          "server"
          "laptop"
          "agentsmith"
        ];
      };
      winbox_addresses = {
        path = "~/.local/share/MikroTik/WinBox";
        ignorePatterns = [
          "!Addresses.cdb"
          "**"
        ];
        versioning = {
          type = "simple";
          params = {
            keep = "10";
            cleanoutDays = "0";
          };
        };
        devices = [
          "server"
          "laptop"
          "agentsmith"
        ];
      };
    };
  };
}
