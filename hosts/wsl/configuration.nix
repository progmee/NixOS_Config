{ config, pkgs, ... }:

{
  imports = [
    # Include hardware scan results
    ./hardware-configuration.nix

    # Include core configuration files
    ../../modules/users.nix
    ../../modules/locale.nix
    ../../modules/networking.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "progme"; # Укажите ваше имя пользователя
  };

  # Define the network hostname for the system
  networking.hostName = "nixos-wsl";

  # Define the system state version (do not change after initial installation)
  system.stateVersion = "26.05";
}