{ config, lib, pkgs, inputs, ... }: # Added 'inputs' to function arguments

{
  imports = [ 
    ./programs/hyprland.nix
    ./hardware-configuration.nix 
    ./core/boot.nix
    ./core/nix-configuration.nix
    ./core/localization.nix
    ./core/nvidia.nix
    ./core/network.nix
    ./core/ssh.nix
    ./programs/nixvim.nix
    ./programs/zsh.nix
    ./programs/git.nix
    ./core/fonts.nix
    ./programs/google-chrome.nix
    ./core/user.nix
    # Import the Ambxst NixOS module directly from the flake inputs
    inputs.ambxst.nixosModules.default
  ];

  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Do not change this value unless you have read the release notes
  system.stateVersion = "24.11";
}
