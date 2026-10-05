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
        vscjava.vscode-gradle
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

    # Dedicated profile for C++ and competitive programming
    profiles."C++" = {
      extensions = commonExtensions ++ [
        # Kylin Clangd
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          publisher = "KylinIdeTeam";
          name = "kylin-clangd";
          version = "0.6.3";
          sha256 = "sha256-KG8Nv1skUNtcn5WWBXAm0PUd1acOl2p45cijresBuWk=";
          sourceUri = "https://open-vsx.org/api/KylinIdeTeam/kylin-clangd/0.6.3/file/KylinIdeTeam.kylin-clangd-0.6.3.vsix";
        })
        # Kylin CMake Workflow / Tools
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          publisher = "KylinIdeTeam";
          name = "kylin-cmake-tools";
          version = "0.4.3";
          sha256 = "sha256-slQyRSqnjt4J/GhE7lDEke2hEZDd+8IIGSf+flLeolw=";
          sourceUri = "https://open-vsx.org/api/KylinIdeTeam/kylin-cmake-tools/0.4.3/file/KylinIdeTeam.kylin-cmake-tools-0.4.3.vsix";
        })
        # C/C++ Debug
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          publisher = "KylinIdeTeam";
          name = "cppdebug";
          version = "0.4.0";
          sha256 = "sha256-BeFmVrZnzyF2MAl7hAKFc17UUg2ovO5clfeDU9riSrY=";
          sourceUri = "https://open-vsx.org/api/KylinIdeTeam/cppdebug/0.4.0/file/KylinIdeTeam.cppdebug-0.4.0.vsix";
        })
      ];
      userSettings = commonSettings // {
        "C_Cpp.default.cppStandard" = "c++20";
      };
    };
  };
}