{ config, pkgs, ... }:

{
  # User identification and home directory configuration
  home.username = "progme";
  home.homeDirectory = "/home/progme";

  # State version for Home Manager compatibility
  home.stateVersion = "26.05";

  # Allow Home Manager to manage itself
  programs.home-manager.enable = true;

  # Import all individual program modules (each program lives in its own file)
  imports = [
    ../../modules/programs/cli
    ../../modules/programs/apps
    ./gnome
  ];
}