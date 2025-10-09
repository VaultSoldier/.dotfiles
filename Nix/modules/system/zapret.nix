{ ... }:
let
  assets = ../../../assets;
  zapretBin = "/etc/zapret/bin";
  zapretlists = "/etc/zapret/lists";
in {
  environment.etc = {
    "zapret/bin/quic_initial_www_google_com.bin".source =
      "${assets}/quic_initial_www_google_com.bin";
    "zapret/bin/tls_clienthello_www_google_com.bin".source =
      "${assets}/tls_clienthello_www_google_com.bin";
    "zapret/lists/ipset-all.txt".source = "${assets}/ipset-all.txt";
    "zapret/lists/list-general.txt".source = "${assets}/list-general.txt";
  };

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
