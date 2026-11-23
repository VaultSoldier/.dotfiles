{ pkgs, lib, ... }:
{
  imports = [
    ./ansible.nix
    ./bitwarden.nix
    ./code.nix
    ./dolphin.nix
    ./gui.nix
    ./kanata.nix
    ./neovim.nix
    ./podman.nix
    ./syncthing.nix
    ./termix.nix
    ./virt-manager.nix
  ];

  packages.bitwarden.enable = lib.mkDefault true;
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
    ncdu # tui du
    fastfetch
    ipfetch
    pi-coding-agent
  ];

  programs.tmux.enable = true;
}
