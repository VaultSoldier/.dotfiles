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
  };
}
