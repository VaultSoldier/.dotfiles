{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";
    spicetify-nix.url = "github:Gerg-L/spicetify-nix";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
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

    # quickshell = {
    #   url =
    #     "git+https://git.outfoxxed.me/outfoxxed/quickshell?ref=49646e4407fce5925920b178872ddd9f8e495218";
    #   inputs.nixpkgs.follows = "nixpkgs";
    # };

    caelestia-shell = {
      url = "github:VaultSoldier/shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    caelestia-cli = {
      url = "github:caelestia-dots/cli";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mikuboot = {
      url = "gitlab:evysgarden/mikuboot";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, plasma-manager, stylix
    , spicetify-nix, zen-browser, caelestia-cli, caelestia-shell, mikuboot, ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules = [
          ./configuration.nix
          ./hosts/desktop
          ./modules/system
          ./modules/packages
          ./modules/packages/games
          ./modules/hardware/nvidia.nix
          ./modules/stylix/sys-stylix.nix
          ./modules/desktop-environments/plasma6.nix

          stylix.nixosModules.stylix
          mikuboot.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "bckp";
            home-manager.users.vs = {
              imports = [
                ./home.nix
                ./modules/home-manager
                ./modules/stylix/hm-stylix.nix
              ];
            };
          }
        ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules = [
          ./configuration.nix
          ./hosts/laptop
          ./modules/system
          ./modules/packages
          ./modules/packages/games/general.nix
          ./modules/stylix/sys-stylix.nix
          ./modules/desktop-environments/hyprland.nix
          ./modules/desktop-environments/caelestia.nix

          stylix.nixosModules.stylix
          mikuboot.nixosModules.default
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "bckp";
            home-manager.users.vs = {
              imports = [
                ./home.nix
                ./modules/home-manager
                ./modules/stylix/hm-stylix.nix
              ];
            };
          }

          {
            environment.systemPackages = [
              caelestia-cli.packages.${system}.default
              caelestia-shell.packages.${system}.default

              # (quickshell.packages.${system}.default.withModules [
              #   pkgs.kdePackages.qtsvg
              #   pkgs.kdePackages.kirigami
              # ])
            ];
          }
        ];
      };
    };
}
