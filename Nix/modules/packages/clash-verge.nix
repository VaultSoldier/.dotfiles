{ pkgs, ... }: {
  programs.clash-verge.tunMode = true;
  programs.clash-verge.serviceMode = true;
  programs.clash-verge.enable = true;
  # programs.clash-verge.package = pkgs.clash-nyanpasu;
}
