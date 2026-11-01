{
  inputs,
  ...
}:
{
  flake.colmenaHive = inputs.colmena.lib.makeHive {
    meta = {
      nixpkgs = import inputs.nixpkgs {
        system = "x86_64-linux";
        overlays = [ ];
      };
    };

    nixbuild =
      {
        name,
        nodes,
        pkgs,
        ...
      }:
      {
        deployment = {
          targetHost = "nixbuild";
        };
        imports = [ ../hosts/nixbuild ];
        networking.hostName = "nixbuild";
      };

    ssk-nixbuild =
      {
        name,
        nodes,
        pkgs,
        ...
      }:
      {
        deployment = {
          targetHost = "ssk-tf-nixos-build";
          targetUser = "root";
        };
        imports = [ ../hosts/ssk-nixbuild ];
        networking.hostName = "tf-nixos-build";
      };
  };
}
