{ ... }: {
  programs.ssh.extraConfig = ''
    Host nixbuild-root
      HostName 192.168.11.127
      User root
      StrictHostKeyChecking ask
      IdentityFile /run/secrets/build_key
  '';

  nix.buildMachines = [
    {
      hostName = "nixbuild-root";
      system = "x86_64-linux";
      maxJobs = 12;
      speedFactor = 1;
      supportedFeatures = [ ];
    }
  ];
  nix.settings = {
    builders-use-substitutes = true;
  };
  nix.distributedBuilds = true;
}
