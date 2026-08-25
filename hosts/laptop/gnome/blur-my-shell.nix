{ pkgs, ... }:

{
  # Install the Blur My Shell GNOME extension
  home.packages = with pkgs; [
    gnomeExtensions.blur-my-shell
  ];

  # Declarative configuration for Blur My Shell via dconf
  dconf.settings = {
    "org/gnome/shell/extensions/blur-my-shell" = {
      rounded-blur-found = false;
      settings-version = 2;
    };

    # Blur effect settings for application folders
    "org/gnome/shell/extensions/blur-my-shell/appfolder" = {
      brightness = 1.0;
      sigma = 10;
    };

    # Blur settings for regular applications
    "org/gnome/shell/extensions/blur-my-shell/applications" = {
      pipeline = "pipeline_default";
    };

    # Blur settings for Coverflow Alt-Tab switcher
    "org/gnome/shell/extensions/blur-my-shell/coverflow-alt-tab" = {
      pipeline = "pipeline_default";
    };

    # Blur settings for Dash to Dock panel/dock
    "org/gnome/shell/extensions/blur-my-shell/dash-to-dock" = {
      blur = true;
      brightness = 0.6;
      pipeline = "pipeline_default_rounded";
      sigma = 30;
      static-blur = true;
      style-dash-to-dock = 0;
    };

    # Blur settings for the lock screen
    "org/gnome/shell/extensions/blur-my-shell/lockscreen" = {
      pipeline = "pipeline_default";
    };

    # Blur settings for the GNOME overview screen
    "org/gnome/shell/extensions/blur-my-shell/overview" = {
      pipeline = "pipeline_default";
    };

    # Blur settings for the top GNOME panel
    "org/gnome/shell/extensions/blur-my-shell/panel" = {
      brightness = 0.6;
      corner-radius = 0;
      override-background = false;
      pipeline = "pipeline_default";
      sigma = 30;
    };

    # Blur settings for screenshots
    "org/gnome/shell/extensions/blur-my-shell/screenshot" = {
      pipeline = "pipeline_default";
    };

    # Blur settings for the window list extension
    "org/gnome/shell/extensions/blur-my-shell/window-list" = {
      brightness = 0.6;
      sigma = 30;
    };
  };
}