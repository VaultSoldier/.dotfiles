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
        server_ip = "hf409axs4qe.sn.mynetname.net";
        privateKey = "/run/secrets/wireguard_key";
        pubKey = "q2WjzV7OcpyxCpGQGKU80e65RrZDi1MdKVtc++LqFBk=";
      in
      {
        split-home = {
          autostart = true;
          address = [
            "192.168.216.5/32"
            "fc00:0:0:216::5/128"
          ];
          dns = [ "192.168.216.1" ];
          privateKeyFile = privateKey;

          peers = [
            {
              allowedIPs = [
                "192.168.11.0/24"
                "192.168.10.0/24"
                "192.168.216.0/24"
              ];
              publicKey = pubKey;
              endpoint = "${server_ip}:61302";
              persistentKeepalive = 15;
            }
          ];
        };

        exit-home = {
          autostart = false;
          address = [
            "192.168.216.5/32"
            "fc00:0:0:216::5/128"
          ];
          dns = [ "192.168.216.1" ];
          privateKeyFile = privateKey;

          peers = [
            {
              allowedIPs = [
                "0.0.0.0/0"
                "::/0"
              ];
              publicKey = pubKey;
              endpoint = "${server_ip}:61302";
              persistentKeepalive = 15;
            }
          ];

          preUp = ''
            systemctl stop wg-quick-exit-home-nolan
            systemctl stop wg-quick-split-home
          '';
          postDown = ''
            systemctl start wg-quick-split-home
          '';
        };

        exit-home-nolan = {
          autostart = false;
          address = [
            "192.168.216.5/32"
            "fc00:0:0:216::5/128"
          ];
          dns = [ "192.168.216.1" ];
          privateKeyFile = privateKey;

          peers = [
            {
              allowedIPs = [
                "0.0.0.0/0"
                "::/0"
              ];
              publicKey = pubKey;
              endpoint = "${server_ip}:61302";
              persistentKeepalive = 15;
            }
          ];

          preUp = ''
            systemctl stop wg-quick-exit-home
            systemctl stop wg-quick-split-home
          '';
          preDown = ''
            ip rule del to 10.0.0.0/8      lookup main priority 50
            ip rule del to 172.16.0.0/12   lookup main priority 50
            ip rule del to 192.168.20.0/24 lookup main priority 50
            ip rule del to 192.168.1.0/24  lookup main priority 50
            ip rule del to 127.0.0.0/8    lookup main priority 50
          '';
          postUp = ''
            ip rule add to 10.0.0.0/8      lookup main priority 50
            ip rule add to 172.16.0.0/12   lookup main priority 50
            ip rule add to 192.168.20.0/24 lookup main priority 50
            ip rule add to 192.168.1.0/24  lookup main priority 50
            ip rule add to 127.0.0.0/8    lookup main priority 50
          '';
          postDown = ''
            systemctl start wg-quick-split-home
          '';
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
      vpn-nolan = "sudo systemctl start wg-quick-exit-home-nolan";
      vpn-off = "sudo systemctl stop wg-quick-exit-home && sudo systemctl stop wg-quick-exit-home-nolan";
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
            command = "/run/current-system/sw/bin/systemctl start wg-quick-exit-home-nolan";
            options = [ "NOPASSWD" ];
          }
          {
            command = "/run/current-system/sw/bin/systemctl stop wg-quick-exit-home-nolan";
            options = [ "NOPASSWD" ];
          }
        ];
      }
    ];
  };
}
