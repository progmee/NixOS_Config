{ pkgs, ... }:

{
  # Install the Dash to Panel GNOME extension
  home.packages = with pkgs; [
    gnomeExtensions.dash-to-panel
  ];

  # Declarative configuration for Dash to Panel via dconf
  dconf.settings = {
    "org/gnome/shell/extensions/dash-to-panel" = {
      animate-appicon-hover-animation-extent = ''{"RIPPLE":4,"PLANK":4,"SIMPLE":1}'';
      appicon-margin = 6;
      appicon-padding = 6;
      dot-position = "BOTTOM";
      dot-style-focused = "DASHES";
      dot-style-unfocused = "DASHES";
      extension-version = 73;
      hide-overview-on-startup = true;
      hotkeys-overlay-combo = "TEMPORARILY";
      leftbox-padding = 4;
      leftbox-size = 16;
      
      # Use monitor index '0' instead of unknown-unknown for reliable application
      panel-anchors = ''{"0":"MIDDLE"}'';
      panel-element-positions = ''{"0":[{"element":"showAppsButton","visible":false,"position":"stackedTL"},{"element":"activitiesButton","visible":false,"position":"stackedTL"},{"element":"leftBox","visible":true,"position":"centerMonitor"},{"element":"taskbar","visible":true,"position":"centerMonitor"},{"element":"centerBox","visible":true,"position":"stackedBR"},{"element":"rightBox","visible":true,"position":"stackedBR"},{"element":"systemMenu","visible":true,"position":"stackedBR"},{"element":"dateMenu","visible":true,"position":"stackedBR"},{"element":"desktopButton","visible":true,"position":"stackedBR"}]}'';
      
      panel-lengths = ''{"0":100}'';
      panel-positions = ''{"0":"BOTTOM"}'';
      panel-sizes = ''{"0":48}'';
      
      prefs-opened = false;
      status-icon-padding = 4;
      tray-padding = 4;
      tray-size = 16;
      window-preview-title-position = "TOP";
      trans-use-custom-opacity = true;
      trans-panel-opacity = 0.9;
    };
  };
}