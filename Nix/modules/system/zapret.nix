{ ... }: {
  services.zapret = {
    enable = true;
    udpSupport = true;
    udpPorts = [ "50000:50099" ];
    params = [
      "--dpi-desync-any-protocol=1" # udp support
      "--filter-l7=discord,stun --dpi-desync=fake --new" # For Discord voice chats
      "--dpi-desync=disorder"
      "--dpi-desync-ttl=1"
      "--dpi-desync-autottl=2"
      "--dpi-desync-repeats=2"
    ];
  };
}
