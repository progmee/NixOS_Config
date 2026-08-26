{ config, pkgs, ... }:

{
  # Allow unfree packages (proprietary software)
  nixpkgs.config.allowUnfree = true;

  # System state version (do not change unless you know what you are doing)
  system.stateVersion = "26.05";
}