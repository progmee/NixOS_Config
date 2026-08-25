{ config, pkgs, ... }:

{
  # Enable Fastfetch (a fast, feature-rich system information tool)
  programs.fastfetch = {
    enable = true;
  };
}