{ config, pkgs, ... }:

{
  # Enable and configure Btop resource monitor via Home Manager
  programs.btop = {
    enable = true;

    # Settings and visual preferences
    settings = {
      color_theme = "default";
      update_ms = 2000;           # Update interval in milliseconds (2 seconds)
      proc_tree = true;           # Group processes in a tree view by default
      show_disks = true;          # Show disk usage meters
    };
  };
}