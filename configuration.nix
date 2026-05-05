# Edit this configuration file to define what should be installed on
# your system. Help is available in the configuration.nix(5) man page, on
# https://search.nixos.org/options and in the NixOS manual (`nixos-help`).

{ config, lib, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
    ];

  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Define a hostname and network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Set your time zone.
  time.timeZone = "Europe/Paris";

  # Select internationalisation properties.
  i18n.defaultLocale = "en_US.UTF-8";

  # Add support for other locales
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  # Allow propriatary software
  nixpkgs.config.allowUnfree = true;
  
  # Use GPU instead of CPU
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"]; # Define video driver
  
  # Configuration of nvidia drivers
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    powerManagement.finegrained = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  # Add language switch within keyboard
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };
  
  # Built-in console configuration
  console = {
    font = "Lat2-Terminus16";
    # keyMap = "us";
    useXkbConfig = true; # use xkb.options in tty.
  };

  # Enable sound.
  security.rtkit.enable = true;
  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
  };
  
  # Enable touchpad support (enabled default in most desktopManager).
  services.libinput.enable = true;

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.progme = {
    isNormalUser = true;
    description = "Default admin user";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ]; # Enable ‘sudo’ for the user.
    
    # Install packages for current user
    packages = with pkgs; [
      neovim
      ghostty
      tmux
      eza
      bat
      ripgrep
      git
      btop
      fd
      fastfetch
      starship
    ];
  };
  
  # Add fonts
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];  

  # List packages installed in system profile.
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    pciutils
    usbutils
    xdg-utils
    wl-clipboard
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  
  # ===================== TMP ==================
  security.sudo.extraRules = [{
    users = [ "progme" ];
    commands = [
      { command = "/run/current-system/sw/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
    ];
  }];

  systemd.services.nixos-git-sync = {
    description = "Sync NixOS config with github";
    serviceConfig = {
      Type = "oneshot";
      User = "progme";
      ExecStart = "/etc/nixos/update.sh";
    };
  };

  systemd.timers.nixos-git-sync = {
     wantedBy = [ "timers.target" ];
     timerConfig = {
       OnBootSec = "1m";
       OnUnitActiveSec = "1m";
       Unit = "nixos-git-sync.service";
     };
  };

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = {
  #   enable = true;
  #   enableSSHSupport = true;
  # };

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Copy the NixOS configuration file and link it from the resulting system
  # (/run/current-system/configuration.nix). This is useful in case you
  # accidentally delete configuration.nix.
  # system.copySystemConfiguration = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system - see https://nixos.org/manual/nixos/stable/#sec-upgrading for how
  # to actually do that.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "25.11"; # Did you read the comment?

}

