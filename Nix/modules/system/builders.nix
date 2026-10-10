{ ... }: {
  programs.ssh.extraConfig = ''
    Host nixbuild-root
      HostName 192.168.11.127
      User root
      StrictHostKeyChecking accept-new
      IdentityFile /run/secrets/build_key

    Host ssk-tf-nixos-build-root
      HostName 10.100.11.154
      User root
      StrictHostKeyChecking accept-new
      IdentityFile /run/secrets/build_key
  '';

  nix = {
    buildMachines = [
      {
        hostName = "nixbuild-root";
        system = "x86_64-linux";
        maxJobs = 12;
        speedFactor = 1;
        supportedFeatures = [ ];
      }
      {
        hostName = "ssk-tf-nixos-build-root";
        system = "x86_64-linux";
        maxJobs = 12;
        speedFactor = 5;
        supportedFeatures = [ ];
      }
    ];

    distributedBuilds = true;
    settings = {
      builders-use-substitutes = true;
    };
  };
}
