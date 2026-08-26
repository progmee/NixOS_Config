{ config, pkgs, ... }:

{
  imports = [
    # Include core configuration files
    ../../modules/core/users.nix
    ../../modules/core/locale.nix
    ../../modules/core/nix.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "progme";
  };

  # Define the network hostname for the system
  networking.hostName = "nixos-wsl";

  # Define the system state version (do not change after initial installation)
  system.stateVersion = "26.05";
}