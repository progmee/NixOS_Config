{ config, pkgs, ... }:
{
  # Zoxide navigation (smart cd replacement with 'z' command)
  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };
}
