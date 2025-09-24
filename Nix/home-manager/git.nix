{ ... }: {
  programs.git = {
    enable = true;
    userName = "VaultSoldier";
    userEmail = "61462705+VaultSoldier@users.noreply.github.com";
    extraConfig = {
      pull.rebase = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      user.signingkey = "~/.ssh/ssh_keys/git_id_ed25519";
    };
  };
}
