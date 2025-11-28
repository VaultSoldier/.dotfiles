{ pkgs, ... }: {
  imports = [
    ./code.nix
    ./neovim.nix
    ./kanata.nix
    ./podman.nix
    ./dolphin.nix
    ./virt-manager.nix
    ./gui.nix
  ];
  
  programs.tmux.enable = true;
  environment.systemPackages = with pkgs; [
    oh-my-posh
    zoxide
    fzf
    ripgrep
    fd
    mc
    whois
    unzip
    unrar
    tealdeer
    xorg.xlsclients
    wineWowPackages.waylandFull
    pulseaudio # pactl
    yt-dlp
    ffmpeg
    speedtest-cli
    stow
    htop
    ncdu
    fastfetch
    ipfetch
  ];
}
