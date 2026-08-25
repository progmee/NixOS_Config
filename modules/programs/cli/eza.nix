{ config, pkgs, ... }:

{
  # Enable and configure Eza (a modern replacement for 'ls') via Home Manager
  programs.eza = {
    enable = true;
    
    # Enable automatic shell integration (adds useful shortcuts)
    enableBashIntegration = true;
    enableZshIntegration = true;
    
    # Enable icons (requires a Nerd Font installed in the system)
    icons = "auto";
    
    # Enable Git status integration in long listing view
    git = true;
    
    # Define custom command aliases for Eza
    # This automatically maps standard commands to eza equivalents
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}