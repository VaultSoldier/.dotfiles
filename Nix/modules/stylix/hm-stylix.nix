{ ... }:
{
  imports = [ ./general-stylix.nix ];

  stylix.enable = true;
  stylix.targets.btop.enable = false;
  stylix.targets.kitty.enable = false;
  stylix.targets.zen-browser.enable = false;
  stylix.targets.vesktop.enable = false;
}
