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
          "suspend-then-hibernate"
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
      { id = "battery"; enabled = true; }
      /*nixfmt:enable*/
    ];

    osd = {
      enableMicrophone = false;
    };
  };
}
