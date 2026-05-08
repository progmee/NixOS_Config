# /etc/nixos/programs/fonts.nix

{ pkgs, ... }:

{
  # Fonts
  fonts.packages = with pkgs; [ 
    # Main Nerd Fonts for icons and terminal
    nerd-fonts.jetbrains-mono
    nerd-fonts.fira-code
    nerd-fonts.meslo-lg
    nerd-fonts.hack
    nerd-fonts.symbols-only # Just icons, very useful for Waybar
  ];
}