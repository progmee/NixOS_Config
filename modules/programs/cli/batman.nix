{ config, pkgs, ... }:

{
  # Enable Bat (a cat clone with syntax highlighting and Git integration)
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      italic-text = "always";
    };
    
    # Install additional bat-related tools (like batman for man pages)
    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };
}