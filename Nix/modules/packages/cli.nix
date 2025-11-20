{ pkgs, ... }:

{
  programs.tmux.enable = true;
  programs.gpu-screen-recorder.enable = true;
  environment.systemPackages = with pkgs; [
    oh-my-posh
    zoxide
    fzf
    ripgrep
    git
    wget
    curl
    fd
    mc
    whois
    unzip
    unrar
    tealdeer
    xorg.xlsclients
    wineWowPackages.stable
    fwupd
    pulseaudio # for pactl
    yt-dlp
    ffmpeg
    speedtest-cli
    stow
    killall
    htop
    ncdu
    fastfetch
    ipfetch
  ];
}
