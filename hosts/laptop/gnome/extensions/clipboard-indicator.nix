{ pkgs, ... }:

{
  # Install the clipboard-indicator extension package
  home.packages = with pkgs.gnomeExtensions; [
    clipboard-indicator
  ];

  # Specific preferences for clipboard-indicator extension
  dconf.settings = {
    "org/gnome/shell/extensions/clipboard-indicator" = {
      blink-icon-on-copy = false;
      cache-only-favorites = true;
      cache-size = 512;
      confirm-clear = false;
      confirm-pinned-delete = true;
      disable-down-arrow = true;
      display-mode = 0;
      enable-keybindings = false;
      history-size = 100;
      preview-size = 10;
      regex-search = true;
      show-preview-button = true;
      show-private-mode = false;
      show-settings-button = false;
      show-tag-button = false;
    };
  };
}