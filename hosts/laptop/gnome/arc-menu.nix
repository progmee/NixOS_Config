{ pkgs, ... }:

{
  home.packages = with pkgs; [
    gnomeExtensions.arc-menu
  ];

  dconf.settings = {
    "org/gnome/shell/extensions/arc-menu" = {
      force-menu-location = "BottomCentered";
      left-panel-width = 175;
      menu-button-icon = "resource:///org/gnome/shell/extensions/arcmenu/icons/scalable/actions/distro-nixos.svg";
      menu-button-icon-size = 35;
      menu-height = 750;
      menu-layout = "11";
      pinned-apps = "[{'id': 'org.gnome.Nautilus.desktop'}, {'id': 'gnome-extensions prefs arcmenu@arcmenu.com', 'name': 'ArcMenu Settings', 'icon': 'ArcMenu_ArcMenuIcon'}]";
      power-options = "[(0, false), (1, true), (2, true), (3, true), (4, false), (5, false), (6, false), (7, false)]";
      prefs-visible-page = 0;
      search-entry-border-radius = "(true, 25)";
      update-notifier-project-version = 73;
    };
  };
}