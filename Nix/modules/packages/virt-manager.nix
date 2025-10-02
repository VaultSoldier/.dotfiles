{ pkgs, ... }: {
  programs.virt-manager.enable = true;
  users.groups.libvirtd.members = [ "vs" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.spiceUSBRedirection.enable = true;

  environment.systemPackages = with pkgs; [ virt-viewer ];
}
