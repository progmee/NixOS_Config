{ config, pkgs, ... }:

{
  # Prism Launcher configuration via Home Manager
  programs.prismlauncher = {
    enable = true;
    
    # Global settings configuration
    settings = {
      Language = "en_US";
      ShowConsole = false;
      ConsoleMaxLines = 100000;
    };
  };
}