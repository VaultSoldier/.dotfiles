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
      affinity-nix,
      caelestia-shell,
      mikuboot,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
    in
    {
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
          ./modules/hardware/fifine-am8.nix
          ./modules/desktop-environments
          ./modules/stylix
          mikuboot.nixosModules.default
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops

          {
            desktop.plasma6.enable = true;
            desktop.hyprland.enable = true;
            desktop.caelestia.enable = true;
            system.flatpak.enable = true;
            games.lutris.enable = false;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "bckp";
            home-manager.users.vs.imports = [ ./modules/home-manager ];
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
          ./modules/packages/games
          ./modules/desktop-environments
          ./modules/stylix
          mikuboot.nixosModules.default
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops

          {
            desktop.plasma6.enable = true;
            desktop.hyprland.enable = true;
            desktop.caelestia.enable = true;
            system.flatpak.enable = true;

            games.osu-lazer.enable = false;
            games.lutris.enable = false;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "bckp";
            home-manager.users.vs.imports = [ ./modules/home-manager ];
          }
        ];
      };

      nixosConfigurations.bronze = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules = [
          ./configuration.nix
          ./hosts/bronze
          ./modules/system
          ./modules/packages
          ./modules/packages/games
          ./modules/desktop-environments
          ./modules/stylix
          mikuboot.nixosModules.default
          home-manager.nixosModules.home-manager
          sops-nix.nixosModules.sops

          {
            desktop.plasma6.enable = false;
            desktop.hyprland.enable = true;
            desktop.caelestia.enable = true;
            system.flatpak.enable = true;

            games.osu-lazer.enable = false;
            games.lutris.enable = false;

            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "bckp";
            home-manager.users.vs.imports = [ ./modules/home-manager ];
          }
        ];
      };
    };
}
