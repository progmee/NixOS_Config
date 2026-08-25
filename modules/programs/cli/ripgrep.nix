{ config, pkgs, ... }:

{
  # Enable and configure Ripgrep (rg) via Home Manager
  programs.ripgrep = {
    enable = true;
    arguments = [
      # Follow symbolic links during search
      "--follow"

      # Case-insensitive search unless uppercase letters are used
      "--smart-case"

      # Ignore version control and common dependency/build output directories
      "--glob=!.git/*"
      "--glob=!node_modules/*"
      "--glob=!.output/*"
      "--glob=!.next/*"
    ];
  };
}