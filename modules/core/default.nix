{ config, lib, pkgs, ... }:

{
  imports = [
    ./boot.nix
    ./networking.nix
    ./locale.nix
    ./users.nix
    ./system.nix
    ./fonts.nix
  ];
}