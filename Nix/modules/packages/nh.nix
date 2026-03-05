{ pkgs, ... }: {
  programs.nh = {
    enable = true;
    flake = "/home/vs/.dotfiles/Nix";
  };
}
