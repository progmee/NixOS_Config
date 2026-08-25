{ pkgs, ... }:

{
  # Install Date Menu Formatter extension package
  home.packages = with pkgs; [
    gnomeExtensions.date-menu-formatter
  ];

  dconf.settings = {
    "org/gnome/shell/extensions/date-menu-formatter" = {
      # Date and time display pattern (dd/MM/yy with a newline followed by HH:mm)
      pattern = "dd/MM/yy\\nHH:mm";
      
      # Text alignment in the top panel
      text-align = "center";
      
      # Update frequency level for the clock ticker
      update-level = 8;
    };
  };
}