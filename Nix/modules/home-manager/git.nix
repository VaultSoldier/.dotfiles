{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      user.name = "VaultSoldier";
      user.email = "61462705+VaultSoldier@users.noreply.github.com";
      user.signingkey = "~/.ssh/ssh_keys/git_id_ed25519";
      init.defaultBranch = "dev";
      pull.rebase = true;
      commit.gpgsign = true;
      gpg.format = "ssh";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
    };
  };
}
