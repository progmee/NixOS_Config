{ config, pkgs, ... }:

{
  # Bootloader configuration: using systemd-boot with EFI support
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
}