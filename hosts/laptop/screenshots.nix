{ pkgs, ... }:

{
  # Declarative dconf configuration for GNOME
  dconf.settings = {
    # Disable conflicting default GNOME shortcuts
    "org/gnome/shell/keybindings" = {
      show-screenshot-ui = [ "Print" ];
      screenshot-window = [ "<Alt>Print" ];
    };
  };
}