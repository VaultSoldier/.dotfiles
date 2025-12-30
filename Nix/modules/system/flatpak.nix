{
  pkgs,
  lib,
  config,
  ...
}:
{
  options.system = {
    flatpak.enable = lib.mkEnableOption "Enable flatpak";
  };

  config = lib.mkIf config.system.flatpak.enable {
    services.flatpak.enable = true;
    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      path = [ pkgs.flatpak ];
      script = ''
        flatpak remote-add --if-not-exists flathub https://flathub.org/repo/flathub.flatpakrepo
        flatpak remote-add --if-not-exists flathub-beta https://flathub.org/beta-repo/flathub-beta.flatpakrepo
      '';
    };

    environment.systemPackages = with pkgs; [ kdePackages.discover ];
  };
}
