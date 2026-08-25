{ pkgs, ... }:

{
  # Enable Lazygit (simple terminal UI for Git commands)
  programs.lazygit = {
    enable = true;
  };
}