# /etc/nixos/programs/fonts.nix

{ pkgs, ... }:

{
  # System-wide font configuration
  fonts.packages = with pkgs; [ 
    # Main Nerd Fonts for icons and terminal
    nerd-fonts.jetbrains-mono
    nerd-fonts.symbols-only
    
    # Fix for the error: renamed from noto-fonts-emoji
    noto-fonts-color-emoji 
    
    # Standard UI fonts often used by AGS
    inter
  ];
}