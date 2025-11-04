{ inputs, pkgs, ... }: {
  imports = [ inputs.spicetify-nix.homeManagerModules.default ];
  programs.spicetify =
    let spicePkgs = inputs.spicetify-nix.legacyPackages.${pkgs.stdenv.system};
    in {
      enable = true;
      wayland = true;

      enabledExtensions = with spicePkgs.extensions; [
        adblockify
        hidePodcasts
        shuffle # shuffle+ (special characters are sanitized out of extension names)
      ];
      enabledCustomApps = with spicePkgs.apps; [
        newReleases
        ncsVisualizer
        marketplace
      ];
      enabledSnippets = with spicePkgs.snippets; [ pointer ];

      # theme = spicePkgs.themes.catppuccin;
      # colorScheme = "mocha";
    };
}
