{ pkgs, ... }:

{
  imports = (import ../../../modules/lib/auto-import.nix ./.) ++ [
    # If you ever need to manually include something outside this folder, add it here:
  ];

  dconf.settings = {
    "org/gnome/shell" = {
      check-extension-version = false;
      disable-user-extensions = false;
      enabled-extensions = [
        "user-theme@gnome-shell-extensions.gcampax.github.com"
        "clipboard-indicator@tudmotu.com"
        "dash-to-panel@jderose9.github.com"
        "arcmenu@arcmenu.com"
        "night-theme-switcher@romainvigier.fr"
        "blur-my-shell@aunetrc"
        "date-menu-formatter@marcinjakubowski.github.com"
        "appindicator@gnuton.github.com"
      ];
    };
  };
}