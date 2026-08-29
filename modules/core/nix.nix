{ config, pkgs, ... }:

{
  # Allow unfree packages (proprietary software)
  nixpkgs.config.allowUnfree = true;

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # System state version (do not change unless you know what you are doing)
  system.stateVersion = "26.05";
}