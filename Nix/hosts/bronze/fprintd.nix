{ config, lib, pkgs, ... }: {
  services.fprintd.enable = true;
  security.pam.services.sudo-rs.fprintAuth = true;
  security.pam.services.sddm.fprintAuth = true;
}
