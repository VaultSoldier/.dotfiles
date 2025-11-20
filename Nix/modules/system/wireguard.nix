{ lib, config, pkgs, ... }: {
  options.system = { wg.enable = lib.mkEnableOption "Enable wireguard"; };

  config = lib.mkIf config.system.wg.enable {
    environment.systemPackages = [ pkgs.wireguard-tools ];
    networking = { wireguard.enable = true; };
    networking.firewall = {
      extraCommands = ''
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --sport 61302 -j RETURN
        ip46tables -t mangle -I nixos-fw-rpfilter -p udp -m udp --dport 61302 -j RETURN
      '';
      extraStopCommands = ''
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --sport 61302 -j RETURN || true
        ip46tables -t mangle -D nixos-fw-rpfilter -p udp -m udp --dport 61302 -j RETURN || true
      '';
    };
  };
}
