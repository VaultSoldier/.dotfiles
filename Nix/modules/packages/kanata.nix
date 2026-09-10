{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ kanata ];

  # Enable the uinput module
  boot.kernelModules = [ "uinput" ];

  # Enable uinput
  hardware.uinput.enable = true;

  # Set up udev rules for uinput
  services.udev.extraRules = ''
    KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
  '';

  # Ensure the uinput group exists
  users.groups.uinput = { };

  # Add the Kanata service user to necessary groups
  systemd.services.kanata-internalKeyboard.serviceConfig = {
    SupplementaryGroups = [
      "input"
      "uinput"
    ];
  };

  services.kanata = {
    enable = true;
    keyboards = {
      internalKeyboard = {
        devices = [ ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defvar
           tap-time 200
           hold-time 200
           rapid-hold-time 150
          )

          (defsrc
           caps d h j k l
           lalt lmet
           1 2 3 4 5 6 7 8 9 0 - =
          )

          (defalias
           caps (tap-hold $tap-time $hold-time esc (layer-toggle arrow))
           del del  ;; Alias for the true delete key action

           ;; hold      -> real Alt, fires as soon as another key is pressed (fast combos)
           ;; tap once  -> normal Alt tap
           ;; tap twice -> press+hold Alt AND toggle the fnrow layer
           lalt (tap-hold-press $tap-time $rapid-hold-time
                  (tap-dance $tap-time (lalt (multi lalt (layer-toggle fnrow))))
                  lalt)
           lmet (tap-hold-press $tap-time $rapid-hold-time
                  (tap-dance $tap-time (lmet (multi lmet (layer-toggle fnrow))))
                  lmet)
          )

          (deflayer base
           @caps d h j k l
           @lalt @lmet
           1 2 3 4 5 6 7 8 9 0 - =
          )

          (deflayer arrow
           _ @del left down up right
           _ _
           _ _ _ _ _ _ _ _ _ _ _ _
          )

          (deflayer fnrow
           _ _ _ _ _ _
           _ _
           f1 f2 f3 f4 f5 f6 f7 f8 f9 f10 f11 f12
          )
        '';
      };
    };
  };
}
