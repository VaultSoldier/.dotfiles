{
  config,
  lib,
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
    package = config.boot.kernelPackages.nvidiaPackages.beta;
  };

  # Containers passthrough
  hardware.nvidia-container-toolkit.enable = true;

  environment.variables = {
    __GL_SHADER_DISK_CACHE_SIZE = "12000000000"; # Increase Nvidia's shader cache size to 12GB
  };
  nixpkgs.config.cudaSupport = true;
  nixpkgs.overlays = [
    (self: super: {
      btop = super.btop.override { cudaSupport = true; };
    })
  ];
  environment.systemPackages = with pkgs; [
    (pkgs.writeShellScriptBin "nvidia-offload" ''
      exec "$@"
    '')
    btop
  ];
}
