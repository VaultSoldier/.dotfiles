{ config, lib, ... }:
{
  options.system = {
    fprintk.enable = lib.mkEnableOption "Enable fprint";
  };

  config = lib.mkIf config.system.fprintd.enable {
    services.fprintd.enable = true;
    security.pam.services.sudo-rs.fprintAuth = true;
    security.pam.services.sddm.fprintAuth = true;
  };
}
