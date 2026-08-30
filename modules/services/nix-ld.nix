{ config, pkgs, ... }:
{
    # Enable nix-ld compatibility tool for NixOS
    programs.nix-ld.enable = true;
}