{ pkgs, inputs, ... }:

let
  # Nix reads your script from the relative path and builds a package from it
  monitorSwitcher = pkgs.writeScriptBin "hypr-monitor-switcher" (builtins.readFile ../scripts/monitor-switcher.sh);
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
    # Set the state version matching your NixOS release (e.g., "24.05", "24.11", etc.)
    home.stateVersion = "24.11"; 

    # Declarative Hyprland configuration via Home Manager
    wayland.windowManager.hyprland = {
      enable = true;

      settings = {
        misc = {
          vfr = false;
        };

        # Trigger the script on Hyprland startup
        "exec-once" = [
          "hypr-monitor-switcher"
        ];

        # Configure keyboard layouts and the switching shortcut (Alt+Shift)
        input = {
          kb_layout = "us,ru";
          kb_options = "grp:alt_shift_toggle";
        };

        bind = [
          "SUPER, C, killactive,"

          "SUPER, Q, exec, ghostty"

          "SUPER SHIFT, left, movewindow, l"
          "SUPER SHIFT, right, movewindow, r"
          "SUPER SHIFT, up, movewindow, u"
          "SUPER SHIFT, down, movewindow, d"
        
          "SUPER, left, movefocus, l"
          "SUPER, right, movefocus, r"
          "SUPER, up, movefocus, u"
          "SUPER, down, movefocus, d"
          "SUPER, F, exec, wofi --show drun --allow-images"
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
    
    monitorSwitcher
    wofi
  ];

  # Enable required background services for UI elements
  services.upower.enable = true;      # Power/Battery status
  services.gvfs.enable = true;        # Virtual filesystem (trash/mounting)
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Enable TTY autologin for the primary user
  services.getty.autologinUser = "progme";
}
