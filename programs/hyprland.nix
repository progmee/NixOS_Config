{ pkgs, inputs, ... }:

{
  # Enable Hyprland Window Manager (System-wide)
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Required for compatibility with older apps
  };

  # Hint for Wayland support in Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Declarative Home Manager configuration for user 'progme'
  home-manager.users.progme = {
    # Set the state version matching your NixOS release (e.g., "24.05", "24.11", etc.)
    home.stateVersion = "24.11"; 

    # Declarative Hyprland configuration via Home Manager
    wayland.windowManager.hyprland = {
      enable = true;
      settings = {
        # Configure keyboard layouts and the switching shortcut (Alt+Shift)
        input = {
          kb_layout = "us,ru";
          kb_options = "grp:alt_shift_toggle";
        };

        # Additional user-specific Hyprland settings can be added here in Nix format:
        # monitor = ",preferred,auto,1";
        # exec-once = "swww init";
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
    
    # UI Logic & Styling dependencies
    bun            
    dart-sass      
    fd             
    
    # Visual effects and wallpaper management
    swww           
    matugen        
    
    # Controls and Monitoring
    brightnessctl  
    wireplumber    
    btop           
    
    # Clipboard and Screenshots
    wl-clipboard   
    grim           
    slurp          
    libnotify      
  ];

  # Enable required background services for UI elements
  services.upower.enable = true;      # Power/Battery status
  services.gvfs.enable = true;        # Virtual filesystem (trash/mounting)
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;

  # Enable TTY autologin for the primary user
  services.getty.autologinUser = "progme";
}
