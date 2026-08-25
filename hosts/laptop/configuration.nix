{ config, pkgs, ... }:

{
  imports = [
    # Include hardware scan results
    ./hardware-configuration.nix

    # Include core system modules (automatically loads default.nix from core folder)
    ../../modules/core

    # Include desktop and multimedia modules
    ../../modules/desktop/gnome.nix
    ../../modules/desktop/sound.nix
  ];

  # Define the network hostname for the system
  networking.hostName = "laptop";

  # Define the system state version (do not change after initial installation)
  system.stateVersion = "26.05";
}