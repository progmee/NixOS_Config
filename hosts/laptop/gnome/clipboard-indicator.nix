{ pkgs, ... }:

{
  # Install the clipboard-indicator extension package
  home.packages = with pkgs.gnomeExtensions; [
    clipboard-indicator
  ];

  # Specific preferences for clipboard-indicator extension
  dconf.settings = {
    "org/gnome/shell/extensions/clipboard-indicator" = {
      history-size = 20;
      cache-size = 512;
    };
  };
}