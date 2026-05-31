{ pkgs, ... }:

{
  # Configure VSCodium settings and extensions declaratively
  programs.vscode = {
    enable = true;
    # Use VSCodium as the package provider
    package = pkgs.vscodium;

    # Define the list of extensions to be installed automatically
    extensions = with pkgs.vscode-extensions; [
      # Nix language support
      bbenoist.nix
      # File icons theme
      pkgs.vscode-extensions.vscode-icons-team.vscode-icons
    ];

    # Settings that will be written to settings.json
    userSettings = {
      # Font settings (ensure 'JetBrainsMono Nerd Font' is installed in your system)
      "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'monospace', monospace";
      "editor.fontSize" = 14;
      "editor.fontLigatures" = true;
      
      # Formatting and editor behavior
      "editor.formatOnSave" = true;
      "editor.minimap.enabled" = false;
      
      # Language server configurations for Nix
      "nix.enableLanguageServer" = true;
      "nix.serverPath" = "nil"; 
      
      # Privacy and update settings
      "telemetry.telemetryLevel" = "off";
      "update.mode" = "none"; # Updates are handled by NixOS/Home Manager
      
      # UI/UX theme settings
      "workbench.iconTheme" = "vscode-icons";
      "editor.renderWhitespace" = "selection";
    };
  };
}
