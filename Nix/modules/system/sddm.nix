{ lib, pkgs, ... }:

let
  customized_sddm_astronaut = pkgs.sddm-astronaut.override { embeddedTheme = "black_hole"; };
in
{
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = lib.mkForce pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtbase
      kdePackages.qtwayland
    ];
    theme = "customized_sddm_astronaut";
    settings = {
      Theme = {
        Current = "sddm-astronaut-theme";
        CursorTheme = "Bibata-Modern-Classic";
      };
    };
  };

  environment.systemPackages = [ customized_sddm_astronaut ];
}
