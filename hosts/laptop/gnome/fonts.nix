{ pkgs, ... }:

{
  # Set clean and modern UI fonts (using Inter as a reliable replacement for Segoe UI)
  dconf.settings = {
    "org/gnome/desktop/interface" = {
      font-name = "Inter 11";
      document-font-name = "Inter 11";
      monospace-font-name = "JetBrainsMono Nerd Font 10";
    };
  };
}