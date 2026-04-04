{ ... }:
{
  programs.caelestia.settings = {
    general.idle.timeouts = [
      {
        timeout = 200;
        idleAction = "lock";
      }
      {
        timeout = 250;
        idleAction = "dpms off";
        returnAction = "dpms on";
      }
      {
        timeout = 600;
        idleAction = [
          "systemctl"
          "suspend-then-hibernate"
        ];
      }
    ];

    services = {
      gpuType = "nvidia";
      weatherLocation = "Tyumen";
    };

    bar = {
      excludedScreens = [ "" ];
    };
    bar.status = {
      showWifi = true;
      showBluetooth = true;
      showBattery = true;
      showMicrophone = false;
    };

    border = {
      rounding = 25;
      thickness = 2;
    };

    utilities.vpn.provider = [
      {
        name = "wireguard";
        interface = "home";
        displayName = "Wireguard (home)";
        enabled = true;
        connectCmd = [
          "sudo"
          "systemctl"
          "start"
          "wg-quick-home"
        ];
        disconnectCmd = [
          "sudo"
          "systemctl"
          "stop"
          "wg-quick-home"
        ];
      }
      {
        name = "wireguard";
        interface = "home-nolan";
        displayName = "Wireguard (home-nolan)";
        enabled = false;
        connectCmd = [
          "sudo"
          "systemctl"
          "start"
          "wg-quick-home-nolan"
        ];
        disconnectCmd = [
          "sudo"
          "systemctl"
          "stop"
          "wg-quick-home-nolan"
        ];
      }
    ];

    utilities.quickToggles = [
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
}
