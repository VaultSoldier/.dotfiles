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

    bar.status = {
      showWifi = true;
      showBluetooth = true;
      showBattery = true;
      showMicrophone = false;
    };

    osd = {
      enableMicrophone = false;
    };

    utilities.vpn.provider = [
      {
        name = "wireguard";
        interface = "home-nolan";
        displayName = "Wireguard (home-nolan)";
        enabled = true;
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
      {
        name = "wireguard";
        interface = "home";
        displayName = "Wireguard (home)";
        enabled = false;
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
    ];
  };
}
