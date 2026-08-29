{ pkgs, ... }:

{
  # List of user packages installed via Home Manager
  home.packages = with pkgs; [
    # GNOME extension to integrate tray icons into the top panel
    gnomeExtensions.appindicator
  ];
}