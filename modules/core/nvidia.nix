{ pkgs, config, ... }:

{
  # GPU / NVIDIA Configuration
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = [ "nvidia" ];
  
  hardware.nvidia = {
    # Modesetting is required for Wayland and Hyprland to function correctly
    modesetting.enable = true;
    
    # Use the proprietary drivers as they are more stable on Wayland for RTX 3050
    open = false;
    
    # Use the stable driver package from the current kernel
    package = config.boot.kernelPackages.nvidiaPackages.stable;

    # Enable the NVIDIA settings configuration utility (nvidia-settings)
    nvidiaSettings = true;

    # NVIDIA Optimus (PRIME) Configuration
    prime = {
      # Sync mode forces the NVIDIA GPU to stay active, 
      # routing the HDMI port directly through the discrete card
      sync.enable = true;

      # Hardware Bus IDs discovered via lspci
      intelBusId = "PCI:0:2:0";
      nvidiaBusId = "PCI:1:0:0";
    };
  };
}
