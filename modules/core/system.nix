{ config, pkgs, ... }:

{
  # Allow unfree packages (proprietary software)
  nixpkgs.config.allowUnfree = true;

  # Enable OpenSSH server daemon
  services.openssh.enable = true;

  # Enable CUPS for document printing
  services.printing.enable = true;

  # System state version (do not change unless you know what you are doing)
  system.stateVersion = "26.05";
}