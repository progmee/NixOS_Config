# /etc/nixos/hardware/nvidia.nix

{ config, ... }:

{
  # GPU / NVIDIA
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
}