{ ... }:
let
  fdCommand = ''
    fd --type f
       --exclude .git --exclude node_modules --exclude .nix-profile
       --exclude "$HOME/.wine/dosdevices/z" --exclude "$HOME/.wine/drive_c"
       --exclude "$HOME/.steam/steam/steamapps/compatdata" --exclude "$HOME/.steam/steam/steamrt64/steam-runtime-steamrt"
  '';
in
{
  programs.fzf = {
    enable = true;
    enableZshIntegration = true;
    defaultCommand = fdCommand;
    fileWidget.command = fdCommand;
  };
}
