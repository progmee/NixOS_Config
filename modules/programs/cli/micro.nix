{ config, pkgs, ... }:

{
  # Enable and configure Micro text editor via Home Manager
  programs.micro = {
    enable = true;
    
    # Basic settings for comfortable quick editing
    settings = {
      # Use standard, clean color scheme
      colorscheme = "atom-dark";
      # Standard tab size
      tabsize = 4;
      # Enable mouse support
      mouse = true;
      # Automatically save file when switching buffers (optional, comment out if unwanted)
      autosave = 0;
    };
  };
}