{ lib, config, ... }:
{
  options.system = {
    ssh.enable = lib.mkEnableOption "Enable openssh";
  };

  config = lib.mkIf config.system.ssh.enable {
    services.openssh = {
      enable = true;
      openFirewall = true;
      ports = [ 2202 ];
      settings = {
        PasswordAuthentication = false;
        KbdInteractiveAuthentication = false;
        PermitRootLogin = "prohibit-password";
        AllowUsers = lib.mkDefault [
          "vs"
        ];
        MaxAuthTries = 3;
        PerSourcePenalties = "crash:3600s authfail:3600s max:86400s";
      };
    };
  };
}
