{ pkgs, ... }:

let
  # Path to cursors directory in assets
  cursorsRoot = ../../../assets/cursors;
in
{
  # Install cursor themes into the user profile using XDG data paths
  # GNOME and X11/Wayland look for cursor themes in ~/.local/share/icons/
  home.file = {
    ".icons/moga-dark".source = "${cursorsRoot}/moga-dark";
    ".icons/moga-white".source = "${cursorsRoot}/moga-white";
  };
}