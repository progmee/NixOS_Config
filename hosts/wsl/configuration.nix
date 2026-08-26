{ config, pkgs, ... }:

{
  imports = [
    # Include core configuration files
    ../../modules/core/users.nix
    ../../modules/core/locale.nix
    ../../modules/core/nix.nix
    ../../modules/services/open-ssh.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "progme";
  };
  wsl.interop.includePath = false;

  # Define the network hostname for the system
  networking.hostName = "progme-wsl";

  # Define the system state version (do not change after initial installation)
  system.stateVersion = "26.05";
}