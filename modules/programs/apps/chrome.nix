{ pkgs, ... }:

{
  # Install Google Chrome package to the user environment
  home.packages = [
    pkgs.google-chrome
  ];

  # Optional: You can configure environment variables or desktop integration if needed
  # (Google Chrome automatically integrates into GNOME app grid and handles URL schemes)
}