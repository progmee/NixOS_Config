{ ... }:

{
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
        "no-overview@fthx"
      ];
    };
  };
}