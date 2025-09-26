{ pkgs, ... }: {
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

  stylix.polarity = "dark";
  stylix.autoEnable = true;
  stylix.targets.gtk.enable = true;
  stylix.targets.qt.enable = true;

}
