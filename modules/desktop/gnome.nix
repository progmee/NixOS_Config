{ config, pkgs, ... }:

{
  # Enable the X11 windowing system
  services.xserver.enable = true;

  # Exclude XTerm globally from X11 services
  services.xserver.excludePackages = [ pkgs.xterm ];

  # Enable the GNOME Desktop Environment and GDM display manager
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  location.provider = "geoclue2"; # Enable location provider
  services.geoclue2.enable = true;

  programs.dconf.enable = true;

  # Configure keyboard layout system-wide (works for Wayland/GNOME sessions too)
  services.xserver.xkb = {
    layout = "us,ru";
    variant = "";
    options = "grp:alt_shift_toggle";
  };

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