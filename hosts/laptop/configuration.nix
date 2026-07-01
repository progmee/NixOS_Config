{ config, lib, pkgs, inputs, ... }:

{
  imports = [
    ../../modules/programs/wofi.nix
    ../../modules/programs/waybar.nix
    ../../modules/screenshot.nix
    ./hardware-configuration.nix 
    ../../modules/core/boot.nix
    ../../modules/programs/waybar.nix
    ../../modules/audio.nix
    ../../modules/core/nix-configuration.nix
    ../../modules/core/localization.nix
    ../../modules/core/nvidia.nix
    ../../modules/core/network.nix
    ../../modules/core/ssh.nix
    ../../modules/core/fonts.nix
    ../../modules/core/aliases.nix
    ../../modules/core/users.nix
    ../../modules/programs/hyprland.nix
    ../../modules/programs/vscodium.nix
    ../../modules/programs/nixvim.nix
    ../../modules/programs/zsh.nix
    ../../modules/programs/git.nix
    ../../modules/programs/google-chrome.nix
    ../../modules/programs/awww.nix
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  system.stateVersion = "24.11";
}