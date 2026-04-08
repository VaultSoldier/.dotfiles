{ ... }: {
  programs.git = {
    enable = true;
    settings = {
      pull.rebase = true;
      commit.gpgsign = true;
      init.defaultBranch = "dev";
      user.name = "VaultSoldier";
      user.email = "61462705+VaultSoldier@users.noreply.github.com";
      user.signingkey = "~/.ssh/pubkeys/git_id_ed25519.pub";
      gpg.ssh.allowedSignersFile = "~/.ssh/allowed_signers";
      gpg.format = "ssh";
    };

    includes = [
      {
        condition = "hasconfig:remote.*.url:ssh://git@gitlab.ssk-yamal.ru*/**";
        contents = {
          user.name = "agent_smith";
          user.email = "35-agent_smith@users.noreply.gitlab.ssk-yamal.ru";
          user.signingkey = "~/.ssh/pubkeys-work/work_id_ed25519.pub";
        };
      }
    ];
  };
}
