{
  pkgs,
  lib,
  config,
  ...
}:
let
  cfg = config.system.flatpak;

  installScript = lib.concatMapStringsSep "\n" (app: ''
    remote=""; ref="${app}"
    if [[ "$ref" == *:* ]]; then remote="''${ref%%:*}"; ref="''${ref#*:}"; fi
    if [[ -n "$remote" ]]; then
      flatpak install --system --assumeyes --noninteractive --or-update "$remote" "$ref"
    else
      flatpak install --system --assumeyes --noninteractive --or-update "$ref"
    fi
  '') cfg.apps;
in
{
  options.system = {
    flatpak = {
      enable = lib.mkEnableOption "flatpak";

      package = lib.mkPackageOption pkgs "flatpak" { };

      remotes = lib.mkOption {
        type = lib.types.attrsOf lib.types.str;
        default = { };
        example = {
          termix = "https://flatpak.termix.site/termix.flatpakrepo";
        };
        description = ''
          Flatpak remotes to add system-wide, as name -> flatpakrepo URL.
          Flathub and the Flathub beta repo are added unless overridden.
        '';
      };

      apps = lib.mkOption {
        type = lib.types.listOf lib.types.str;
        default = [ ];
        example = [
          "termix:com.karmaa.termix"
          "org.mozilla.firefox"
        ];
        description = ''
          Flatpak apps to install system-wide, optionally prefixed with a remote
          name ("remote:app.id"). Installed and updated by a oneshot service.
        '';
      };

      autoUpdate = lib.mkOption {
        type = lib.types.bool;
        default = true;
        description = "Weekly systemd timer that runs `flatpak update`.";
      };
    };
  };

  config = lib.mkIf cfg.enable {
    services.flatpak.enable = true;

    system.flatpak.remotes.flathub = lib.mkOptionDefault "https://flathub.org/repo/flathub.flatpakrepo";
    system.flatpak.remotes.flathub-beta = lib.mkOptionDefault "https://flathub.org/beta-repo/flathub-beta.flatpakrepo";

    systemd.services.flatpak-repo = {
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      path = [ cfg.package ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
      };
      script = lib.concatStringsSep "\n" (
        lib.mapAttrsToList (name: url: ''
          flatpak remote-add --if-not-exists "${name}" "${url}"
        '') cfg.remotes
      );
    };

    systemd.services.flatpak-apps = lib.mkIf (cfg.apps != [ ]) {
      wantedBy = [ "multi-user.target" ];
      wants = [ "network-online.target" ];
      after = [
        "flatpak-repo.service"
        "network-online.target"
      ];
      requires = [ "flatpak-repo.service" ];
      path = [ cfg.package ];
      serviceConfig = {
        Type = "oneshot";
        RemainAfterExit = true;
        Restart = "on-failure";
        RestartSec = "30s";
      };
      script = installScript;
    };

    systemd.services.flatpak-update = lib.mkIf (cfg.autoUpdate && cfg.apps != [ ]) {
      path = [ cfg.package ];
      wants = [ "network-online.target" ];
      after = [ "network-online.target" ];
      serviceConfig = {
        Type = "oneshot";
        # A failed update must not leave the unit failed forever.
        Restart = "on-failure";
        RestartSec = "1h";
      };
      script = ''
        flatpak update --assumeyes --noninteractive
      '';
    };

    systemd.timers.flatpak-update = lib.mkIf (cfg.autoUpdate && cfg.apps != [ ]) {
      wantedBy = [ "timers.target" ];
      timerConfig = {
        OnCalendar = "weekly";
        Persistent = true;
        RandomizedDelaySec = "4h";
      };
    };

    environment.systemPackages = with pkgs; [ kdePackages.discover ];
  };
}
