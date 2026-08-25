{ pkgs, ... }:

{
  # Use the dedicated VSCodium module for proper paths and settings
  programs.vscodium = {
    enable = true;

    # Default profile configuration (updated Home Manager syntax)
    profiles.default = {
      # Essential extensions for development and Nix ecosystem support
      extensions = with pkgs.vscode-extensions; [
        # Allows switching environments using the Nix Package Manager
        arrterian.nix-env-selector
        
        # Full Nix language support with formatting and error reporting
        jnoortheen.nix-ide
      ];
    };
  };
}