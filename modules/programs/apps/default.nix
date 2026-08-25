{ config, pkgs, ... }:

{
  # Automatically and recursively import all .nix files and modules in this directory
  imports = import ../../lib/auto-import.nix ./.;
}