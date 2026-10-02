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
        idleAction = [ "suspend" ];
      }
    ];

    bar.statusIcons = [
      /*nixfmt:disable*/
      { enabled = false; id = "lockStatus"; }
      { enabled = true; id = "audio"; }
      { enabled = false; id = "microphone"; }
      { enabled = true; id = "kbLayout"; }
      { enabled = true; id = "network"; }
      { enabled = true; id = "bluetooth"; }
      { enabled = false; id = "battery"; }
      /*nixfmt:enable*/
    ];
    bar.tray = {
      background = false;
      iconSubs = [ ];
    };

    lock.enableSessionControls = true;
    osd.enableMicrophone = true;

    services = {
      weatherLocation = "Tyumen";
      gpuType = "nvidia";
    };

    session = {
      icons.hibernate = "moon_stars";
      commands.hibernate = [ "suspend" ];
    };

    utilities.vpn = {
      enabled = false;
      provider = [ ];
    };

    utilities.quickToggles = [
      /*nixfmt:disable*/
      { enabled = false; id = "wifi"; }
      { enabled = true; id = "bluetooth"; }
      { enabled = true; id = "mic"; }
      { enabled = true; id = "settings"; }
      { enabled = true; id = "gameMode"; }
      { enabled = true; id = "dnd"; }
      { enabled = false; id = "vpn"; }
      /*nixfmt:enable*/
    ];
  };
}
