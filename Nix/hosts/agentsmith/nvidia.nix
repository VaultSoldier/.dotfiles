{ pkgs, ... }:
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
    nvidiaBusId = "PCI:1:0:0";
    intelBusId = "PCI:0:2:0";
  };

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = true;
    nvidiaSettings = true;
  };

  # Containers passthrough
  hardware.nvidia-container-toolkit.enable = true;

  nixpkgs.config.cudaSupport = true;
  nixpkgs.overlays = [
    (self: super: {
      btop = super.btop.override { cudaSupport = true; };
    })
  ];
  environment.systemPackages = with pkgs; [ btop vulkan-loader ];

  environment.sessionVariables = {
    LD_LIBRARY_PATH = [ "/run/current-system/sw/lib" ];
    VK_ICD_FILENAMES = "/run/opengl-driver/share/vulkan/icd.d/nvidia_icd.json";
    QMD_LLAMA_GPU = "vulkan";
  };
}
