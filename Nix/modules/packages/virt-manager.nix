{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.packages = {
    virtualisation.enable = lib.mkEnableOption "Enable virtualisation tools";
  };

  config = lib.mkIf config.packages.virtualisation.enable {
    programs.virt-manager.enable = true;
    virtualisation.libvirtd.enable = true;
    virtualisation.spiceUSBRedirection.enable = true;
    users.groups.libvirtd.members = [ "vs" ];
    environment.systemPackages = with pkgs; [ virt-viewer ];
  };
}
