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
          "suspend"
        ];
      }
    ];

    bar.statusIcons = [
      /*nixfmt:disable*/
      { id = "lockStatus"; enabled = false; }
      { id = "audio"; enabled = true; }
      { id = "microphone"; enabled = false; }
      { id = "kbLayout"; enabled = true; }
      { id = "network"; enabled = true; }
      { id = "bluetooth"; enabled = true; }
      { id = "battery"; enabled = false; }
      /*nixfmt:enable*/
    ];
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
        "poweroff"
      ];
      suspend = [
        "suspend"
      ];
      reboot = [
        "reboot"
      ];
    };

    utilities.vpn = {
      enabled = false;
      provider = [ ];
    };

    utilities.quickToggles = [
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
