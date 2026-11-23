{
  config,
  lib,
  pkgs,
  ...
}:
let
  bwGetPassword = itemName: ''
    set -euo pipefail
    exec bw-sops get password "${itemName}"
  '';

  ansible-vault-pass = pkgs.writeShellScriptBin "ansible-vault-pass" (bwGetPassword "ansible vaults");
in
{
  config = lib.mkMerge [
    {
      environment.systemPackages = [ pkgs.ansible ];
    }

    (lib.mkIf config.packages.bitwarden.enable {
      environment.systemPackages = [ ansible-vault-pass ];
      environment.sessionVariables.ANSIBLE_VAULT_PASSWORD_FILE = "/run/current-system/sw/bin/ansible-vault-pass";
    })
  ];
}
