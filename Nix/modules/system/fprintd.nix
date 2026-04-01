{ config, lib, ... }:
{
  options.system = {
    fprintd.enable = lib.mkEnableOption "Enable fprintd";
  };

  config = lib.mkIf config.system.fprintd.enable {
    services.fprintd.enable = true;
    security.pam.services.sudo-rs.fprintAuth = true;
    security.pam.services.sddm.fprintAuth = true;
  };
}
