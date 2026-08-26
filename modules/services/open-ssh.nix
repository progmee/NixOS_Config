{ config, pkgs, ... }:

{
  # Enable OpenSSH server daemon
  services.openssh.enable = true;

  # System state version (do not change unless you know what you are doing)
  system.stateVersion = "26.05";
}