{ ... }:
{
  programs.caelestia.settings = {
    general.idle.timeouts = [
      {
        timeout = 250;
        idleAction = "dpms off";
        returnAction = "dpms on";
      }
      {
        timeout = 300;
        idleAction = "lock";
      }
      {
        timeout = 600;
        idleAction = [
          "systemctl"
          "suspend-then-hibernate"
        ];
      }
    ];

    bar.status = {
      showWifi = false;
      showBluetooth = true;
      showBattery = true;
      showMicrophone = false;
    };

    osd = {
      enableMicrophone = false;
    };
  };
}
