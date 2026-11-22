{ ... }:
{
  imports = [ ./general-stylix.nix ];

  stylix.enable = true;

  gtk.colorScheme = "dark";
  stylix.targets.btop.enable = false;
  stylix.targets.kitty.enable = false;
  stylix.targets.zen-browser.enable = false;
  stylix.targets.vesktop.enable = false;
  stylix.targets.spicetify.enable = false;
  # home-manager removed programs.wayprompt (nixpkgs dropped the wayprompt pkg),
  # but stylix still themes it -> "option definition no longer has any effect".
  stylix.targets.wayprompt.enable = false;
}
