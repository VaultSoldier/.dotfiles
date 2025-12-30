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
        devices = [
          # Laptop
          "/dev/input/by-path/platform-i8042-serio-0-event-kbd"
          # Langtu LT75
          "/dev/input/by-id/usb-SONiX_LT75PR0-USB-event-kbd"
          "/dev/input/by-id/usb-05ac_LT75PRO-2.4G-event-kbd"
        ];
        extraDefCfg = "process-unmapped-keys yes";
        config = ''
          (defsrc
           caps d h j k l
           ;; caps tab d h j k l
          )
          (defvar
           tap-time 200
           hold-time 200
          )
          (defalias
           caps (tap-hold $tap-time $hold-time esc (layer-toggle arrow))
           ;; tab (tap-hold $tap-time $hold-time tab (layer-toggle arrow))
           del del  ;; Alias for the true delete key action
          )
          (deflayer base
           ;; @caps @tab d h j k l
           @caps d h j k l
          )
          (deflayer arrow
           ;; _ _ @del left down up right
           _ @del left down up right
          )
        '';
      };
    };
  };
}
