{ config, pkgs, ... }:

{
  # Install FreeCAD and related CAD/rendering utilities via Home Manager
  home.packages = with pkgs; [
    freecad
    gmsh     # Required for Finite Element Method (FEM) simulations in FreeCAD
    povray   # Used for high-quality rendering via the Raytracing Workbench
  ];

  # Environment variables (useful for HiDPI scaling or display server adjustments)
  home.sessionVariables = {
    # QT_AUTO_SCREEN_SCALE_FACTOR = "1";
    # QT_QPA_PLATFORM = "wayland"; # Uncomment if forcing Wayland is needed
  };

  # Optional: Manage FreeCAD configuration files via symlinks from your dotfiles
  # xdg.configFile."FreeCAD" = {
  #   source = ./freecad-config; # Path to your local configuration folder
  #   recursive = true;
  # };
}