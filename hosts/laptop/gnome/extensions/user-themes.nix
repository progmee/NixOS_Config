{ pkgs, ... }:

{
  # Install the User Themes GNOME extension
  home.packages = with pkgs.gnomeExtensions; [
    user-themes
  ];
}