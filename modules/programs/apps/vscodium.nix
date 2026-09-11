{ config, pkgs, ... }:

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

    # Dedicated Java development profile configuration
    profiles.Java = {
      # Essential extensions for Java development and building
      extensions = with pkgs.vscode-extensions; [
        # Comprehensive Java language support, refactoring, and navigation
        redhat.java
        
        # Debugger support for Java applications
        vscjava.vscode-java-debug
        
        # Test Runner for Java to execute JUnit and TestNG tests
        vscjava.vscode-java-test
        
        # Maven project management and build integration
        vscjava.vscode-maven
        
        # Project Manager for Java to easily manage workspace folders
        vscjava.vscode-java-dependency
      ];

      # Specific editor settings optimized for Java development
      userSettings = {
        "java.configuration.updateBuildConfiguration" = "automatic";
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
        "editor.fontSize" = 14;
      };
    };

    # Dedicated OCaml development profile configuration
    profiles.OCaml = {
      # Essential extensions for OCaml development, syntax, and tooling
      extensions = with pkgs.vscode-extensions; [
        # Full OCaml language support and LSP integration
        ocamllabs.ocaml-platform
      ];

      # Specific editor settings optimized for OCaml development
      userSettings = {
        "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
        "editor.fontSize" = 14;
        # Use the allowed 'global' sandbox mode
        "ocaml.sandbox" = {
          "kind" = "global";
        };
        # Point directly to the OCaml LSP server binary from Nix
        "ocaml.server.path" = "/etc/profiles/per-user/progme/bin/ocamllsp";
        "ocaml.compiler.path" = "/etc/profiles/per-user/progme/bin/ocaml";
      };
    };
  };
}