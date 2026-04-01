{ ... }:
{
  imports = [ ./general-stylix.nix ];

  stylix.enable = true;
  stylix.targets.kde.enable = false;
  stylix.targets.btop.enable = false;
  stylix.targets.kitty.enable = false;
  stylix.targets.zen-browser.enable = false;
  stylix.targets.vesktop.enable = false;
  stylix.targets.spicetify.enable = false;
}
