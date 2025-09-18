{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    zen-browser = {
      url = "github:0xc000022070/zen-browser-flake";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "git+https://git.outfoxxed.me/outfoxxed/quickshell";
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

  outputs = inputs@{ self, nixpkgs, home-manager, zen-browser, quickshell
    , caelestia-cli, mikuboot, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      lib = nixpkgs.lib;
    in {
      nixosConfigurations.desktop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules = [
          ./configuration.nix
          ./hosts/desktop/init.nix
          ./system/flatpak.nix
          ./modules/shared.nix
          ./modules/hardware/nvidia.nix
          ./modules/packages/plasma6.nix

          mikuboot.nixosModules.default
          zen-browser.packages.${system}.default
        ];
      };

      nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
        inherit system;
        specialArgs = inputs;

        modules = [
          ./configuration.nix
          ./hosts/laptop/init.nix
          ./modules/hardware/nvidia.nix
          ./modules/shared.nix

          ./modules/packages/caelestia.nix
          mikuboot.nixosModules.default

          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.extraSpecialArgs = { inherit inputs; };
            home-manager.backupFileExtension = "bckp";
            home-manager.users.vs = ./home.nix;
          }

          {
            environment.systemPackages = with pkgs; [
              caelestia-cli.packages.${system}.default

              (quickshell.packages.${system}.default.withModules [
                pkgs.kdePackages.qtsvg
                pkgs.kdePackages.kirigami
              ])
            ];

            environment.sessionVariables.XDG_DATA_DIRS = lib.mkForce
              ("${pkgs.kdePackages.breeze}/share:"
                + "${pkgs.material-symbols}/share:" + "$XDG_DATA_DIRS");
          }
        ];
      };
    };
}
