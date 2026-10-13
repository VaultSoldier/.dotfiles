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
        privateKey_work = "/run/secrets/wg_work_key";
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
                "192.168.0.0/24"
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

        exit-work = {
          autostart = false;
          listenPort = 51820;
          address = [
            "192.168.216.7/32"
            "fc00:0:0:216::7/128"
          ];
          dns = [ "192.168.216.1" ];
          privateKeyFile = privateKey_work;

          peers = [
            # Default route: everything goes through this tunnel except the
            # subnets claimed by split-home (alwayson) — its more specific /24
            # routes win in the kernel routing table while both are up.
            {
              allowedIPs = [
                "0.0.0.0/0"
                "::/0"
              ];
              publicKey = "jRnN+5bbk2D410ASvKUxdtw/qEZ87uU03SUwxmOOK0Q=";
              endpoint = "hjr0azpe3x8.vpn.mynetname.net:50865";
              persistentKeepalive = 30;
            }
          ];
        };
      };

    networking.firewall = {
      # rpfilter drops replies that arrive on an interface inconsistent with
      # the routing table (asymmetric routing via the wg interface); exempt
      # UDP 61302 in both directions so that traffic keeps flowing.
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
      vpn-work = "sudo systemctl start wg-quick-exit-work";
      vpn-work-off = "sudo systemctl stop wg-quick-exit-work";
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
          {
            command = "/run/current-system/sw/bin/systemctl start wg-quick-exit-work";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl stop wg-quick-exit-work";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
