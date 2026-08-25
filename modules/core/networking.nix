{ config, pkgs, ... }:

{
  # Enable NetworkManager for network management
  networking.networkmanager.enable = true;
}