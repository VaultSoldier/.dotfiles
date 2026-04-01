{ config, pkgs, ... }:
{
  # Enable OpenGL
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  # Load nvidia driver for Xorg and Wayland
  services.xserver.videoDrivers = [
    "modesetting"
    "nvidia"
  ];

  hardware.nvidia.prime = {
    offload = {
      enable = true;
      enableOffloadCmd = true;
    };
    intelBusId = "PCI:0:2:0";
    nvidiaBusId = "PCI:1:0:0";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    open = true;
    nvidiaSettings = true;
  };

  # Containers passthrough
  hardware.nvidia-container-toolkit.enable = true;

  environment.systemPackages = with pkgs; [ btop ];
  nixpkgs.overlays = [ (self: super: { btop = super.btop.override { cudaSupport = true; }; }) ];
  nixpkgs.config.cudaSupport = true;
}
