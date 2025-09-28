{ pkgs, ... }: {
  stylix.base16Scheme = "${pkgs.base16-schemes}/share/themes/dracula.yaml";

  stylix.autoEnable = true;
  stylix.polarity = "dark";

  stylix.cursor.package = pkgs.bibata-cursors;
  stylix.cursor.name = "Bibata-Modern-Classic";
  stylix.cursor.size = 24;
}
