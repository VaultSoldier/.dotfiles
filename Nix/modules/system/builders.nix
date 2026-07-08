{ ... }: {
  nix.buildMachines = [
    {
      hostName = "nixbuild";
      system = "x86_64-linux";
      sshUser = "build";
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
