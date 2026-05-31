{ pkgs, inputs, ... }:

let
  # Create binaries from your local .sh files
  monitor-switcher = pkgs.writeShellScriptBin "monitor-switcher" (builtins.readFile ../scripts/monitor-switcher.sh);
  monitor-watcher = pkgs.writeShellScriptBin "monitor-watcher" (builtins.readFile ../scripts/monitor-watcher.sh);
in
{
  # Enable Hyprland Window Manager (System-wide)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Required for compatibility with older apps
  };
  
  # Hint for Wayland support in Electron apps
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    QSG_USE_SIMPLE_ANIMATION_DRIVER = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Declarative Home Manager configuration for user 'progme'
  home-manager.users.progme = {
    # Set the state version matching your NixOS release
    home.stateVersion = "24.11"; 

    # Declarative Hyprland configuration via Home Manager
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        exec-once = [
          "monitor-switcher"
          "monitor-watcher"
        ];

        monitor = [
          "HDMI-A-1, preferred, auto, 1.25"
          "eDP-1, preferred, auto, 1.25"
          ", preferred, auto, 1"
        ];

        bindm = [
          "SUPER, mouse:272, movewindow"
          "SUPER, mouse:273, resizewindow"
        ];

        misc = {
          vfr = false;
        };

        # Configure keyboard layouts and the switching shortcut (Alt+Shift)
        input = {
          kb_layout = "us,ru";
          kb_options = "grp:alt_shift_toggle";
        };

        bind = [
          "SUPER, C, killactive,"

          "SUPER, Q, exec, ghostty"
          "SUPER, F, exec, wofi --show drun --allow-images"

          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"
        
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"

          "SUPER SHIFT, 1, movetoworkspace, 1"
          "SUPER SHIFT, 2, movetoworkspace, 2"
          "SUPER SHIFT, 3, movetoworkspace, 3"
          "SUPER SHIFT, 4, movetoworkspace, 4"
          "SUPER SHIFT, 5, movetoworkspace, 5"
          "SUPER SHIFT, 6, movetoworkspace, 6"
          "SUPER SHIFT, 7, movetoworkspace, 7"
          "SUPER SHIFT, 8, movetoworkspace, 8"
          "SUPER SHIFT, 9, movetoworkspace, 9"
          "SUPER SHIFT, 0, movetoworkspace, 10"

          "SUPER, 1, workspace, 1"
          "SUPER, 2, workspace, 2"
          "SUPER, 3, workspace, 3"
          "SUPER, 4, workspace, 4"
          "SUPER, 5, workspace, 5"
          "SUPER, 6, workspace, 6"
          "SUPER, 7, workspace, 7"
          "SUPER, 8, workspace, 8"
          "SUPER, 9, workspace, 9"
          "SUPER, 0, workspace, 10"

          "SUPER, mouse_down, workspace, e+1"
          "SUPER, mouse_up, workspace, e-1"
        ];
      };
    };
  };

  # Required for screen sharing and screenshots in Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Ambxst uses this for recording features
  programs.gpu-screen-recorder.enable = true;

  # Automatically launch Hyprland when logging into tty1
  environment.loginShellInit = ''
    if [ -z $DISPLAY ] && [ "$(tty)" = "/dev/tty1" ]; then
      exec start-hyprland
    fi
  '';

  # System-wide packages for the AMBXST / AGS UI
  environment.systemPackages = with pkgs; [
    # AGS engine from flake inputs
    inputs.ags.packages.${pkgs.system}.default 
    wofi
    socat              # Utility for interacting with the Hyprland socket
    monitor-switcher   # Our monitor switching script
    monitor-watcher    # Our event listening script
  ];

  # Enable required background services for UI elements
  services.upower.enable = true;      # Power/Battery status
  services.gvfs.enable = true;        # Virtual filesystem (trash/mounting)
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Enable TTY autologin for the primary user
  services.getty.autologinUser = "progme";
}
