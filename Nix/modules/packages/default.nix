{ pkgs, lib, ... }:
{
  imports = [
    ./code.nix
    ./dolphin.nix
    ./gui.nix
    ./kanata.nix
    ./neovim.nix
    ./podman.nix
    ./syncthing.nix
    ./virt-manager.nix
  ];

  packages.virtualisation.enable = lib.mkDefault false;

  environment.systemPackages = with pkgs; [
    oh-my-posh
    zoxide # cd alternative
    eza # ls alternative
    ripgrep # faster grep alternative
    fd # fast alternative to find
    whois
    unzip
    unrar
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

  programs.tmux.enable = true;
}
