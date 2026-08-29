{ pkgs, ... }:

{
  # Install the extension that disables the overview screen on startup
  home.packages = with pkgs; [
    gnomeExtensions.no-overview
  ];
}