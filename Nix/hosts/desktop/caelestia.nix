{ ... }:
{
  programs.caelestia.settings = {
    general.idle.timeouts = [
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

    bar.status = {
      showAudio = true;
      showBattery = false;
      showBluetooth = true;
      showMicrophone = false;
      showWifi = false;
    };
    bar.tray = {
      background = false;
      iconSubs = [ ];
    };

    osd = {
      enableMicrophone = true;
    };

    services = {
      gpuType = "nvidia";
      weatherLocation = "Chelyabinsk";
    };

    session.commands = {
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

    utilities.vpn = {
      enabled = false;
      provider = [ ];
    };

    utilities.vpn.utilities.quickToggles = [
      {
        id = "wifi";
        enabled = false;
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
        enabled = false;
      }
    ];
  };
}
