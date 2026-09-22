{
  pkgs,
  lib,
  config,
  ...
}:
let
  bitwardenPasswordFile = "/run/secrets/bitwarden_master_password";

  bw-unlock-sops = pkgs.writeShellScriptBin "bw-unlock-sops" ''
    set -euo pipefail
    exec ${pkgs.bitwarden-cli}/bin/bw unlock --passwordfile ${bitwardenPasswordFile} --raw
  '';

  bw-sops = pkgs.writeShellScriptBin "bw-sops" ''
    set -euo pipefail

    SESSION_CACHE_DIR="/run/user/$(id -u)/bitwarden-sops"
    SESSION_CACHE_FILE="$SESSION_CACHE_DIR/session.key"
    SESSION_TIMESTAMP_FILE="$SESSION_CACHE_DIR/timestamp"
    SESSION_TTL=$(( 7 * 24 * 60 * 60 )) # 7 days

    mkdir -p "$SESSION_CACHE_DIR"
    chmod 700 "$SESSION_CACHE_DIR"

    get_cached_session() {
      if [[ -f "$SESSION_CACHE_FILE" && -f "$SESSION_TIMESTAMP_FILE" ]]; then
        local cache_age=$(( $(date +%s) - $(cat "$SESSION_TIMESTAMP_FILE") ))
        if [[ $cache_age -lt $SESSION_TTL ]]; then
          cat "$SESSION_CACHE_FILE"
          return 0
        fi
      fi
      return 1
    }

    cache_session() {
      local session_key="$1"
      echo "$session_key" > "$SESSION_CACHE_FILE"
      date +%s > "$SESSION_TIMESTAMP_FILE"
      chmod 600 "$SESSION_CACHE_FILE"
      chmod 600 "$SESSION_TIMESTAMP_FILE"
    }

    case "''${1-}" in
      login|logout|lock|unlock|config|status)
        exec ${pkgs.bitwarden-cli}/bin/bw "$@"
        ;;
    esac

    if BW_SESSION=$(get_cached_session); then
      export BW_SESSION
      if ${pkgs.bitwarden-cli}/bin/bw unlock --check >/dev/null 2>&1; then
        exec ${pkgs.bitwarden-cli}/bin/bw "$@"
      fi
    fi

    BW_SESSION="$(${pkgs.bitwarden-cli}/bin/bw unlock --passwordfile ${bitwardenPasswordFile} --raw)"
    cache_session "$BW_SESSION"

    export BW_SESSION
    exec ${pkgs.bitwarden-cli}/bin/bw "$@"
  '';

  bwGetPassword = itemName: ''
    set -euo pipefail
    exec bw-sops get password "${itemName}"
  '';

  ansible-vault-pass = pkgs.writeShellScriptBin "ansible-vault-pass" (bwGetPassword "ansible vaults");
in
{
  options.packages.bitwarden = {
    enable = lib.mkEnableOption "Bitwarden tools" // {
      default = true;
    };
    desktop.enable = lib.mkEnableOption "Bitwarden Desktop" // {
      default = true;
    };
    ansible.enable = lib.mkEnableOption "Bitwarden-backed Ansible password helpers" // {
      default = true;
    };
  };

  config = lib.mkIf config.packages.bitwarden.enable {
    environment.systemPackages = [
      pkgs.bitwarden-cli
      bw-unlock-sops
      bw-sops
    ]
    ++ lib.optional config.packages.bitwarden.desktop.enable pkgs.bitwarden-desktop
    ++ lib.optionals config.packages.bitwarden.ansible.enable [
      ansible-vault-pass
    ];

    environment.sessionVariables = lib.mkIf config.packages.bitwarden.ansible.enable {
      ANSIBLE_VAULT_PASSWORD_FILE = "/run/current-system/sw/bin/ansible-vault-pass";
    };

    environment.shellAliases = {
      bw = "bw-sops";
    };
  };
}
