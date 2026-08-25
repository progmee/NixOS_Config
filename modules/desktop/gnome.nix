{ config, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Exclude XTerm globally from X11 services
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Enable the GNOME Desktop Environment and GDM display manager
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  # Configure keyboard layout in X11
  services.xserver.xkb = {
    layout = "us";
    variant = "";
  };

  location.provider = "geoclue2"; # Enable location provider

  # Exclude unnecessary default GNOME applications and utilities
  environment.gnome.excludePackages = with pkgs; [
    pkgs.gnome-backgrounds # Remove default gnome backgrounds

    # Remaining apps from the screenshot
    gnome-console       # GNOME Console terminal
    totem               # Videos player
    
    # Web & Email
    epiphany
    geary
    
    # Media & Utilities
    gnome-calculator
    gnome-music
    cheese
    snapshot
    gnome-tour
    gnome-contacts
    gnome-maps
    gnome-weather
    gnome-clocks
    gnome-calendar
    gnome-characters
    yelp
    
    # GNOME Games
    iagno
    tali
    hitori
    four-in-a-row
    atomix
    quadrapassel
    swell-foop
    five-or-more
    gnome-chess
    gnome-klotski
    gnome-mahjongg
    gnome-mines
    gnome-nibbles
    gnome-robots
    gnome-sudoku
    gnome-tetravex
  ];
}