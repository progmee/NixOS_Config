{ pkgs, ... }:

{
  home-manager.users.progme = {
    
    # 1. Wofi installation and configuration
    programs.wofi = {
      enable = true;
      settings = {
        width = 400;
        height = 300;
        prompt = "Search...";
        hide_scroll = true;
        show_icons = true;
        term = "ghostty"; # Replace with your preferred terminal
        layer = "overlay";
        allow_markup = true;
      };
    };

    # 2. Visual styling (CSS)
    # This creates the configuration file for Wofi styling
    home.file.".config/wofi/style.css".text = ''
      * {
        font-family: "JetBrainsMono Nerd Font", sans-serif;
        font-size: 14px;
      }

      window {
        margin: 0px;
        border: 2px solid #89b4fa;
        background-color: #1e1e2e;
        border-radius: 15px;
      }

      #input {
        margin: 10px;
        border: none;
        color: #cdd6f4;
        background-color: #313244;
        border-radius: 5px;
      }

      #inner-box {
        margin: 5px;
      }

      #entry {
        padding: 5px;
        margin: 2px;
        border-radius: 5px;
        background-color: transparent;
      }

      #entry:selected {
        background-color: #89b4fa;
        color: #1e1e2e;
      }
    '';

    # 3. Hyprland keybinding
    wayland.windowManager.hyprland.settings = {
      bind = [
        # Closes Wofi if open, or launches it if closed
        "SUPER, F, exec, pkill wofi || wofi --show drun"
      ];
    };
  };
}