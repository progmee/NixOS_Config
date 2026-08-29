{ pkgs, ... }:

{
  # Use the dedicated VSCodium module for proper paths and settings
  programs.vscodium = {
    enable = true;

    # Default profile configuration
    profiles.default = {
      # Essential extensions for development and Nix ecosystem support
      extensions = with pkgs.vscode-extensions; [
        # Allows switching environments using the Nix Package Manager
        arrterian.nix-env-selector
        
        # Full Nix language support with formatting and error reporting
        jnoortheen.nix-ide
      ];

      # Editor font configuration including Nerd Font Mono
      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
        "editor.fontSize" = 14;
      };
    };
  };
}