{ config, pkgs, ... }:

{
  # Home Manager packages configuration for C++ workflow
  home.packages = with pkgs; [
    # Core C++ compiler collection (includes g++, gcc)
    gcc
    
    # GNU Debugger for debugging C++ code
    gdb
    
    # Cross-platform build system generator
    cmake
    ninja # Faster alternative for project building
  ];
}