{ config, pkgs, ... }:

{
  home-manager.users.progme = {
    programs.waybar = {
      enable = true;
      
      systemd = {
        enable = true;
        target = "hyprland-session.target";
      };

      settings = {
        mainBar = {
          layer = "top";
          position = "top";
          height = 30;
          spacing = 4;
          
          modules-left = [ "hyprland/workspaces" "hyprland/window" ];
          modules-center = [ "clock" ];
          modules-right = [ "pulseaudio" "network" "battery" "tray" ];

          "hyprland/workspaces" = {
            format = "{icon}";
            on-click = "activate";
            format-icons = {
              "1" = "1";
              "2" = "2";
              "3" = "3";
              "4" = "4";
              "5" = "5";
              "urgent" = "";
              "default" = "";
            };
          };

          "hyprland/window" = {
            max-length = 50;
          };

          "clock" = {
            format = "{:%H:%M  %d.%m.%Y}";
            tooltip-format = "<tt>{calendar}</tt>";
          };

          "pulseaudio" = {
            format = "{volume}% {icon}";
            format-muted = " Muted";
            format-icons = {
              default = [ "" "" ];
            };
            on-click = "pavucontrol"; 
          };

          "network" = {
            format-wifi = "{essid} ";
            format-ethernet = "{ipaddr}/{cidr} 󰊗";
            format-disconnected = "⚠ Disconnected";
            tooltip-format = "{ifname} via {gwaddr}";
          };

          "battery" = {
            states = {
              warning = 30;
              critical = 15;
            };
            format = "{capacity}% {icon}";
            format-charging = "{capacity}% ";
            format-plugged = "{capacity}% ";
            format-icons = [ "" "" "" "" "" ];
          };

          "tray" = {
            icon-size = 18;
            spacing = 10;
          };
        };
      };

      style = ''
        * {
          border: none;
          border-radius: 0;
          font-family: "JetBrainsMono Nerd Font", sans-serif;
          font-size: 14px;
          min-height: 0;
        }

        window#waybar {
          background: rgba(30, 30, 46, 0.9);
          color: #cdd6f4;
        }

        #workspaces button {
          padding: 0 10px;
          color: #cdd6f4;
          background: transparent;
        }

        #workspaces button:hover {
          background: rgba(255, 255, 255, 0.1);
        }

        #workspaces button.active {
          color: #89b4fa;
          font-weight: bold;
        }

        #clock,
        #battery,
        #pulseaudio,
        #network,
        #tray,
        #window {
          padding: 0 15px;
          margin: 0 5px;
        }

        #battery.warning {
          color: #f9e2af;
        }

        #battery.critical {
          color: #f38ba8;
          font-weight: bold;
        }
      '';
    };
  };
}