{ pkgs, ... }:

{
  # Install Ghostty package to the user environment
  home.packages = [
    pkgs.ghostty
  ];

  # Configure Ghostty terminal settings and keybindings
  programs.ghostty = {
    enable = true;
    
    settings = {      
      # Set the font family (make sure the font is installed on your system)
      font-family = "JetBrainsMono Nerd Font";
      font-size = 12;
      
      # Window decorations (true for native title bar/borders, false for borderless)
      window-decoration = true;
      
      # Slight background transparency (1.0 is fully opaque)
      background-opacity = 0.95;

      # Automatic theme switching using built-in themes
      theme = "dark:Adwaita Dark,light:Adwaita";
    };
  };
}