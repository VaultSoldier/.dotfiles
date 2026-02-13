{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake/beta";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    stylix = {
      url = "github:nix-community/stylix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    plasma-manager = {
      url = "github:nix-community/plasma-manager";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.home-manager.follows = "home-manager";
    };
    caelestia-shell = {
      url = "github:VaultSoldier/shell?ref=NightLight";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    mikuboot = {
      url = "gitlab:evysgarden/mikuboot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      sops-nix,
      plasma-manager,
      stylix,
      spicetify-nix,
      zen-browser,
      caelestia-shell,
      mikuboot,
      ...
    }:
    let
      system = "x86_64-linux";
      commonModules = [
        ./configuration.nix
        ./modules/desktop-environments
        ./modules/packages/games
        ./modules/packages
        ./modules/stylix
        ./modules/system
        mikuboot.nixosModules.default
        home-manager.nixosModules.home-manager
        sops-nix.nixosModules.sops
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
          home-manager.backupFileExtension = "bckp";
          home-manager.users.vs.imports = [ ./modules/home-manager ];
        }
      ];
    in
    {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          {
            desktop = {
              plasma6.enable = true;
              hyprland.enable = true;
              caelestia.enable = true;
            };
            games = {
              lutris.enable = false;
            };
            system = {
              flatpak.enable = true;
            };

            home-manager.users.vs.imports = [ ./hosts/desktop/home-manager.nix ];
          }
          ./hosts/desktop
          ./modules/hardware/nvidia.nix
          ./modules/hardware/fifine-am8.nix
        ]
        ++ commonModules;
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          {
            desktop = {
              plasma6.enable = true;
              hyprland.enable = true;
              caelestia.enable = true;
            };
            games = {
              osu-lazer.enable = false;
              lutris.enable = false;
            };
            system = {
              flatpak.enable = true;
            };

            home-manager.users.vs.imports = [ ./hosts/laptop/home-manager.nix ];
          }
          ./hosts/laptop
        ]
        ++ commonModules;
      };

      nixosConfigurations.bronze = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;
        modules = [
          {
            desktop = {
              plasma6.enable = false;
              hyprland.enable = true;
              caelestia.enable = true;
            };
            games = {
              osu-lazer.enable = false;
              lutris.enable = false;
            };
            system = {
              flatpak.enable = true;
            };

            home-manager.users.vs.imports = [ ./hosts/bronze/home-manager.nix ];
          }
          ./hosts/bronze
        ]
        ++ commonModules;
      };
    };
}
