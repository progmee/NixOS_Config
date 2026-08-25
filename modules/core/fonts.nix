{ pkgs, ... }:

{
  # Install system-wide fonts (JetBrains Mono Nerd Font for terminals and Inter for general UI)
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
    inter
  ];
}