{ pkgs, inputs, ... }:

{
  # Enable Hyprland Window Manager
  programs.hyprland = {
    enable = true;
    xwayland.enable = true; # Required for older apps compatibility
  };

  # System-wide packages for the AMBXST / AGS UI
  environment.systemPackages = with pkgs; [
    # AGS (Aylur's GTK Shell) - The UI engine from the video
    inputs.ags.packages.${pkgs.system}.default 
    
    # Dependencies for the shell to work
    bun            # Modern JS runtime for AGS scripts
    dart-sass      # Compiles the beautiful CSS styles
    fd             # Fast find for file searching
    btop           # System monitor
    networkmanager # For the Wi-Fi toggle in the UI
    bluez          # Bluetooth support
    brightnessctl  # Brightness control for the slider
    wireplumber    # Audio control
    
    # Visuals and Wallpapers
    swww           # Animated wallpaper daemon
    matugen        # Generates colors from wallpapers (Material You style)
    
    # Utilities
    wl-clipboard   # Copy/Paste support
    grim           # Screen capture (backend)
    slurp          # Screen region selector
    libnotify      # Notification system
  ];

  # Enable required services for the UI Notch/Panel
  services.upower.enable = true;      # Battery/Power tracking
  services.gvfs.enable = true;        # File system mounting/mounting icons
  networking.networkmanager.enable = true;
  hardware.bluetooth.enable = true;
}