{ config, pkgs, ... }:

{
  programs.bat = {
    enable = true;
    config = {
      theme = "TwoDark";
      italic-text = "always";
    };
    
    extraPackages = with pkgs.bat-extras; [
      batman
    ];
  };
}