{ config, lib, ... }:

{
  options.system = {
    power_management.enable = lib.mkEnableOption "Enable power_management";
  };

  config = lib.mkIf config.system.power_management.enable {
    services.upower.enable = true;
    services.power-profiles-daemon.enable = true;
  };
}
