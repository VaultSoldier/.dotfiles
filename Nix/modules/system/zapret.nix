{ ... }: {
  services.zapret = {
    enable = true;
    params = [
      "--filter-udp=50000-50099 --filter-l7=discord,stun --dpi-desync=fake --new" # For Discord voice chats
      "--dpi-desync=fake,disorder2"
      "--dpi-desync-ttl=1"
      "--dpi-desync-autottl=2"
    ];
  };
}
