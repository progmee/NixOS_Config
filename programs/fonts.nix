# /etc/nixos/programs/fonts.nix

{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [ 
    nerd-fonts.jetbrains-mono 
  ];
}