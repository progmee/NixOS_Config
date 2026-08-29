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

    # Apply Sleek GRUB theme
    theme = pkgs.sleek-grub-theme;

    # Limit number of generations
    configurationLimit = 3;
  };

  # Remove unimportant text on boot
  boot.consoleLogLevel = 3;
  boot.initrd.verbose = false;

  boot.initrd.systemd.enable = true;

  # Add kernel params to hide unnecessary messages from screen
  boot.kernelParams = [
    "quiet"
    "splash"
    "boot.shell_on_fail"
    "udev.log_priority=3"
  ];
}