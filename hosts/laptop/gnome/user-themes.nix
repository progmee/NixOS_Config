{ pkgs, ... }:

{
  home.packages = with pkgs.gnomeExtensions; [
    user-themes
  ];
}