# /etc/nixos/configuration.nix

{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
    ./core/boot.nix
    ./core/nix-settings.nix
    ./core/localization.nix
    ./nvidia.nix
    ./programs/nixvim.nix
    ./programs/shell.nix
    ./programs/fonts.nix
    ./users/progme.nix
  ];

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11";
}