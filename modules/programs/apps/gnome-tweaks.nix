{ config, pkgs, ... }:

{
  # Install GNOME Tweaks for user-level desktop customization via Home Manager
  home.packages = with pkgs; [
    gnome-tweaks
  ];
}