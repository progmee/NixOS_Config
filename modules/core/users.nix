{ config, pkgs, ... }:

{
  # Enable zsh system-wide to satisfy NixOS assertions for user login shell
  programs.zsh.enable = true;

  # Make Zsh available as a valid system shell
  environment.shells = with pkgs; [ zsh ];

  # Define user account and permissions
  users.users."progme" = {
    isNormalUser = true;
    description = "Aleksandr";
    extraGroups = [ "networkmanager" "wheel" "vboxsf" ];
    shell = pkgs.zsh;
  };
}