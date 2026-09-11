{ config, pkgs, ... }:

let
  # Shared extensions included in all profiles (utilities, themes, git tools)
  commonExtensions = with pkgs.vscode-extensions; [
    streetsidesoftware.code-spell-checker
    pkief.material-icon-theme
    johnpapa.vscode-peacock
    tomoki1207.pdf
  ];

  # Common editor settings applied across profiles (fonts, explorer behaviors, icon theme)
  commonSettings = {
    "editor.fontFamily" = "'JetBrainsMono Nerd Font', 'Droid Sans Mono', 'monospace', monospace";
    "editor.fontSize" = 14;
    "explorer.confirmDelete" = false;
    "explorer.confirmDragAndDrop" = false;
    "workbench.iconTheme" = "material-icon-theme";
  };
in
{
  # VSCodium configuration via Home Manager with profile separation
  programs.vscodium = {
    enable = true;

    # Default fallback profile containing general tooling and themes
    profiles.default = {
      extensions = commonExtensions;
      userSettings = commonSettings;
    };

    # Specialized profile for Nix language development
    profiles.Nix = {
      extensions = commonExtensions ++ (with pkgs.vscode-extensions; [
        arrterian.nix-env-selector
        jnoortheen.nix-ide
      ]);
      userSettings = commonSettings;
    };

    # Dedicated profile for Java development and project building
    profiles.Java = {
      extensions = commonExtensions ++ (with pkgs.vscode-extensions; [
        redhat.java
        vscjava.vscode-java-debug
        vscjava.vscode-java-test
        vscjava.vscode-maven
        vscjava.vscode-java-dependency
      ]);
      userSettings = commonSettings // {
        "java.configuration.updateBuildConfiguration" = "automatic";
      };
    };

    # Dedicated profile for OCaml development with explicit binary paths
    profiles.OCaml = {
      extensions = commonExtensions ++ (with pkgs.vscode-extensions; [
        ocamllabs.ocaml-platform
      ]);
      userSettings = commonSettings // {
        "ocaml.sandbox" = {
          "kind" = "global";
        };
        "ocaml.server.path" = "/etc/profiles/per-user/progme/bin/ocamllsp";
        "ocaml.compiler.path" = "/etc/profiles/per-user/progme/bin/ocaml";
      };
    };
  };
}