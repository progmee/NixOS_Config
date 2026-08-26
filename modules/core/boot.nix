{ config, pkgs, ... }:

{
  # Bootloader configuration: using GRUB with EFI support
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev"; # Раскомментируйте, если используется UEFI (обычно требуется для EFI)
  };
}