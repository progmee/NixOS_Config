{ pkgs, ... }:

{
  # Install Google Chrome package to the user environment
  home.packages = [
    pkgs.google-chrome
  ];
}