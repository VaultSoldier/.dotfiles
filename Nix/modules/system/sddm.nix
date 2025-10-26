{ lib, pkgs, ... }:

let
  customized_sddm_astronaut =
    pkgs.sddm-astronaut.override { embeddedTheme = "black_hole"; };
in {
  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    package = lib.mkForce pkgs.kdePackages.sddm;
    extraPackages = with pkgs; [
      kdePackages.qtbase
      kdePackages.qtwayland
      kdePackages.qtmultimedia
      kdePackages.qtvirtualkeyboard
    ];
    theme = "customized_sddm_astronaut";
    settings = { Theme = { Current = "sddm-astronaut-theme"; }; };
  };

  environment.systemPackages = [ customized_sddm_astronaut ];
}
