{ config, pkgs, ... }:

{
  imports = [
    # Include core configuration files
    ../../modules/core/users.nix
    ../../modules/core/locale.nix
    ../../modules/core/nix.nix
    ../../modules/services

    # Fix WSL visibility on VSCodium
    ./nix-ld.nix
  ];

  wsl = {
    enable = true;
    defaultUser = "progme";
    wslConf = {
      interop.appendWindowsPath = false;
    };
  };

  # Define the network hostname for the system
  networking.hostName = "wsl";

  # Define the system state version (do not change after initial installation)
  system.stateVersion = "26.05";
}
