{ ... }:
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = ''
      fd --type f --exclude 
          "$HOME/.wine/dosdevices/z" "$HOME/.wine/drive_c"
          "$HOME/.steam/steam/steamapps/compatdata" "$HOME/.steam/steam/steamrt64/steam-runtime-steamrt"
    '';
    fileWidgetCommand = ''
      fd --type f --exclude 
          "$HOME/.wine/dosdevices/z" "$HOME/.wine/drive_c"
          "$HOME/.steam/steam/steamapps/compatdata" "$HOME/.steam/steam/steamrt64/steam-runtime-steamrt"
    '';
  };
}
