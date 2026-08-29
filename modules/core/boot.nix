{ config, pkgs, ... }:

{
  # Bootloader configuration: using GRUB with EFI support
  boot.loader.systemd-boot.enable = false;
  boot.loader.efi.canTouchEfiVariables = true;

  boot.loader.grub = {
    enable = true;
    efiSupport = true;
    device = "nodev";
    useOSProber = true;
    gfxmodeEfi = "1920x1080";

    theme = pkgs.sleek-grub-theme;
  };
}