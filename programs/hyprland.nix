{ pkgs, inputs, ... }:

{
  # Enable Hyprland Window Manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Required for compatibility with older apps
  };

  # Hint for Wayland support in Electron apps
  environment.sessionVariables.NIXOS_OZONE_WL = "1";

  # Required for screen sharing and screenshots in Hyprland
  xdg.portal = {
    enable = true;
    extraPortals = [ pkgs.xdg-desktop-portal-hyprland ];
  };

  # Ambxst uses this for recording features
  programs.gpu-screen-recorder.enable = true;

  # System-wide packages for the AMBXST / AGS UI
  environment.systemPackages = with pkgs; [
    # AGS engine from flake inputs [cite: 7]
    inputs.ags.packages.${pkgs.system}.default 
    
    # UI Logic & Styling dependencies [cite: 7]
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

  # Enable a hyprland service on start
  services.displayManager = {
    autoLogin = {
      enable = true;
      user = "progme";
    };
    defaultSession = "hyprland";
  };

  services.getty.autologinUser = "progme";
}