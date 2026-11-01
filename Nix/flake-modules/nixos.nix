{
  inputs,
  ...
}:
let
  system = "x86_64-linux";
  commonModules = [
    ../configuration.nix
    ../modules/desktop-environments
    ../modules/packages/games
    ../modules/packages
    ../modules/stylix
    ../modules/system
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
      home-manager.extraSpecialArgs = { inherit inputs; };
      home-manager.backupFileExtension = null;
      home-manager.users.vs.imports = [ ../modules/home-manager ];
    }
  ];
in
{
  flake.nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      {
        desktop = {
          plasma6.enable = true;
          hyprland.enable = true;
          caelestia.enable = true;
        };
        packages = {
          virtualisation.enable = true;
        };
        games = {
          osu.enable = true;
        };
        system = {
          flatpak.enable = false;
          wg.enable = false;
          ssh.enable = true;
        };

        home-manager.users.vs.imports = [ ../hosts/desktop/home-manager.nix ];
      }
      ../hosts/desktop
      ../modules/hardware/nvidia.nix
      ../modules/hardware/fifine-am8.nix
    ]
    ++ commonModules;
  };

  flake.nixosConfigurations.agentsmith = inputs.nixpkgs.lib.nixosSystem {
    inherit system;
    specialArgs = { inherit inputs; };
    modules = [
      {
        desktop = {
          plasma6.enable = false;
          hyprland.enable = true;
          caelestia.enable = true;
        };
        games = {
          steam.enable = true;
          prismlauncher.enable = false;
          osu.enable = false;
          lutris.enable = false;
        };
        system = {
          wg.enable = true;
          ssh.enable = true;
          power_management.enable = true;
        };

        home-manager.users.vs.imports = [ ../hosts/agentsmith/home-manager.nix ];
      }
      ../hosts/agentsmith
      ../modules/hardware/intel.nix
    ]
    ++ commonModules;
  };
}
