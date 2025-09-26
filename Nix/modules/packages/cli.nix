{ pkgs, ... }:

{
  programs.tmux.enable = true;

  environment.systemPackages = with pkgs; [
    oh-my-posh
    git
    wget
    curl
    zoxide
    ripgrep
    fzf
    fd
    mc
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
