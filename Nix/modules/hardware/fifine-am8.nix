{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [ alsa-utils ];

  systemd.services.mute-fifine = {
    description = "Mute FIFINE Microphone";
    wantedBy = [ "multi-user.target" ];

    serviceConfig = {
      Type = "oneshot";
      ExecStart = [ "${pkgs.alsa-utils}/bin/amixer -D hw:Microphone sset Mic off" ];
    };
  };
}
