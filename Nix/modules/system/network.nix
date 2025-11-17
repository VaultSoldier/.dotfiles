{ pkgs, ... }: {
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  networking = {
    networkmanager.enable = true;
    networkmanager.dispatcherScripts = [{
      source = pkgs.writeShellScript "nm-wg-auto" ''
        #!/bin/bash
        IFACE="$1"
        STATUS="$2"
        SSID_EXCLUDE="5G_ИЗЛУЧАТЕЛЬ_COVID19"
        WG_CONN="wg-home"

        # Only trigger on Wi-Fi up
        if [ "$STATUS" = "up" ]; then
            CURRENT_SSID=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
            if [ "$CURRENT_SSID" = "$SSID_EXCLUDE" ]; then
                nmcli connection down "$WG_CONN"
            else
                nmcli connection up "$WG_CONN"
            fi
        fi
      '';
    }];
    wireguard.enable = true;
  };

  environment.systemPackages = [ pkgs.wireguard-tools ];

  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # wireguard trips rpfilter up
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
  networking.firewall.allowedTCPPorts = [ ];
  networking.firewall.allowedUDPPorts = [ ];
  networking.firewall.enable = true;
}
