{ ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = ''fd --type f --exclude ".steam/steam/steamapps/compatdata" ".steam/steam/steamrt64/steam-runtime-steamrt"'';
    fileWidgetCommand = ''fd --type f --exclude ".steam/steam/steamapps/compatdata" ".steam/steam/steamrt64/steam-runtime-steamrt"'';
  };
}
