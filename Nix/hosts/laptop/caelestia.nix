{ ... }:
{
  programs.caelestia.settings = {
    general.idle.timeouts = [
      {
        timeout = 200;
        idleAction = "dpms off";
        returnAction = "dpms on";
      }
      {
        timeout = 250;
        idleAction = "lock";
      }
      {
        timeout = 600;
        idleAction = [
          "systemctl"
          "hybrid-sleep"
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
