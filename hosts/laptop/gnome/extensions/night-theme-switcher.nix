{ pkgs, ... }:

{
  # Install Night Theme Switcher extension package
  home.packages = with pkgs; [
    gnomeExtensions.night-theme-switcher
  ];

  dconf.settings = {
    "org/gnome/shell/extensions/nightthemeswitcher" = {
      # Enable automatic theme switching functionality
      enabled = true;
      
      # Use geolocation/sun schedule instead of a fixed manual timetable
      manual-schedule = false;
      
      # Global shortcut to trigger theme switching on demand
      nightthemeswitcher-ondemand-keybinding = [ "<Shift><Super>t" ];
      
      # Shell command executed at sunrise (light cursor theme and light shell theme)
      sunrise = "gsettings set org.gnome.desktop.interface cursor-theme 'moga-white' && dconf write /org/gnome/shell/extensions/user-theme/name \"'fluent-gtk-theme-master-Light'\"";
      
      # Shell command executed at sunset (dark cursor theme and dark shell theme)
      sunset = "gsettings set org.gnome.desktop.interface cursor-theme 'moga-dark' && dconf write /org/gnome/shell/extensions/user-theme/name \"'fluent-gtk-theme-master-Dark'\"";
    };
  };
}