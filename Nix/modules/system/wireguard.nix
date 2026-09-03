{
  lib,
  config,
  pkgs,
  ...
}:
{
  options.system = {
    wg.enable = lib.mkEnableOption "Enable wireguard";
  };

  config = lib.mkIf config.system.wg.enable {
    environment.systemPackages = [ pkgs.wireguard-tools ];

    networking.wireguard.enable = true;
    networking.wg-quick.interfaces =
      let
        server_endpoint = "hj20a9erp9b.vpn.mynetname.net";
        privateKey_full = "/run/secrets/wg_full_key";
        privateKey_alwaysOn = "/run/secrets/wg_alwayson_key";
        pubKey = "sZyVXC7ma/OrExzPnGrO/pAsDxMvrkn7iljTpRx3Oh8=";
      in
      {
        split-home = {
          autostart = false;
          address = [
            "192.168.216.5/32"
            "fc00:0:0:216::5/128"
          ];
          dns = [ "192.168.216.1" ];
          privateKeyFile = privateKey_alwaysOn;

          peers = [
            {
              allowedIPs = [
                "192.168.11.0/24"
                "192.168.10.0/24"
                "192.168.216.0/24"
              ];
              publicKey = pubKey;
              endpoint = "${server_endpoint}:47842";
              persistentKeepalive = 15;
            }
          ];
        };

        exit-home = {
          autostart = false;
          address = [
            "192.168.216.4/32"
            "fc00:0:0:216::4/128"
          ];
          dns = [ "192.168.216.1" ];
          privateKeyFile = privateKey_full;

          peers = [
            {
              allowedIPs = [
                "0.0.0.0/0"
                "::/0"
              ];
              publicKey = pubKey;
              endpoint = "${server_endpoint}:47842";
              persistentKeepalive = 15;
            }
          ];
        };
      };

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

    environment.shellAliases = {
      vpn-full = "sudo systemctl start wg-quick-exit-home";
      vpn-off = "sudo systemctl stop wg-quick-exit-home";
      vpn-alwayson = "sudo systemctl start wg-quick-split-home";
      vpn-alwaysoff = "sudo systemctl stop wg-quick-split-home";
    };

    security.sudo-rs.extraRules = [
      {
        users = [ "vs" ];
        commands = [
          {
            command = "/run/current-system/sw/bin/systemctl start wg-quick-split-home";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl stop wg-quick-split-home";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl start wg-quick-exit-home";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl stop wg-quick-exit-home";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
