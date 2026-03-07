{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      pull.rebase = true;
      commit.gpgsign = true;
      init.defaultBranch = "dev";
      user.name = "VaultSoldier";
      user.email = "61462705+VaultSoldier@users.noreply.github.com";
      user.signingkey = "~/.ssh/git_id_ed25519.pub";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      gpg.format = "ssh";
    };
  };
}
