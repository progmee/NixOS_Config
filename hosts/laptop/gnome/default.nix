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
      
      # Switch individual windows globally instead of grouped applications (Windows style)
      switch-windows = [ "<Alt>Tab" ];
      switch-windows-backward = [ "<Shift><Alt>Tab" ];
      switch-applications = [ ];
      switch-applications-backward = [ ];

      # Windows-style virtual desktop switching (Ctrl + Win + Left/Right)
      switch-to-workspace-left = [ "<Control><Super>Left" ];
      switch-to-workspace-right = [ "<Control><Super>Right" ];
    };

    "org/gnome/desktop/interface" = {
      # Disable the activities overview hot corner on mouse hover
      enable-hot-corners = false;
    };

    "org/gnome/shell/app-switcher" = {
      # Include windows from all workspaces in Alt + Tab
      current-workspace-only = false;
    };
  };
}