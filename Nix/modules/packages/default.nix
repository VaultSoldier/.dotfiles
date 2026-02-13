{ pkgs, ... }:
{
  imports = [
    ./code.nix
    ./neovim.nix
    ./kanata.nix
    ./podman.nix
    ./dolphin.nix
    ./virt-manager.nix
    ./syncthing.nix
    ./nh.nix
    ./gui.nix
  ];

  programs.tmux.enable = true;
  environment.systemPackages = with pkgs; [
    oh-my-posh
    zoxide # cd alternative
    eza # ls alternative
    fzf
    ripgrep # faster grep alternative
    fd # fast alternative to find
    whois
    unzip
    unrar
    ansible
    tealdeer
    xlsclients
    wineWow64Packages.waylandFull
    pulseaudio # pactl
    yt-dlp
    ffmpeg
    trash-cli
    speedtest-cli
    stow
    htop
    ncdu # gui du
    fastfetch
    ipfetch
  ];
}
