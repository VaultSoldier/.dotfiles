{
  config,
  pkgs,
  ...
}:

{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
    open = true;
    nvidiaSettings = true;
    package =
      let
        base = config.boot.kernelPackages.nvidiaPackages.beta;
        cachyos-nvidia-patch = pkgs.fetchpatch {
          url = "https://raw.githubusercontent.com/CachyOS/CachyOS-PKGBUILDS/master/nvidia/nvidia-utils/kernel-6.19.patch";
          sha256 = "sha256-YuJjSUXE6jYSuZySYGnWSNG5sfVei7vvxDcHx3K+IN4=";
        };

        # Patch the appropriate driver based on config.hardware.nvidia.open
        driverAttr = if config.hardware.nvidia.open then "open" else "bin";
      in
      base
      // {
        ${driverAttr} = base.${driverAttr}.overrideAttrs (oldAttrs: {
          patches = (oldAttrs.patches or [ ]) ++ [ cachyos-nvidia-patch ];
        });
      };
  };

  nixpkgs.config.cudaSupport = true;

  # Containers passthrough
  hardware.nvidia-container-toolkit.enable = true;

  environment.variables = {
    __GL_SHADER_DISK_CACHE_SIZE = "12000000000"; # Increase Nvidia's shader cache size to 12GB
  };
  environment.systemPackages = with pkgs; [ btop ];
  nixpkgs.overlays = [ (self: super: { btop = super.btop.override { cudaSupport = true; }; }) ];
}
