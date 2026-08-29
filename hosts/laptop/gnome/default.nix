{ lib, ... }:

{
  imports = (import ../../../modules/lib/auto-import.nix ./.) ++ [
    # If you ever need to manually include something outside this folder, add it here:
  ];

  # Gnome preferences settings
  dconf.settings = {
    "org/gnome/desktop/wm/preferences" = {
      button-layout = "appmenu:minimize,maximize,close";
    };

    "org/gnome/desktop/wm/keybindings" = {
      # Hide all normal windows and show the desktop using Win + D
      show-desktop = [ "<Super>d" ];
    };
  };

  # Enable extensions for gnome
  dconf.settings = {
    "org/gnome/shell" = {
      check-extension-version = false;
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "clipboard-indicator@tudmotu.com"
        "dash-to-panel@jderose9.github.com"
        "arcmenu@arcmenu.com"
        "nightthemeswitcher@romainvigier.fr"
        "blur-my-shell@aunetx"
        "date-menu-formatter@marcinjakubowski.github.com"
      ];
    };
  };
}