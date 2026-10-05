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
        pkgs.vscode-extensions.formulahendry.code-runner
        # Kylin C++ Pack downloaded directly from Open VSX
        (pkgs.vscode-utils.extensionFromVscodeMarketplace {
          publisher = "KylinIdeTeam";
          name = "kylin-cpp-pack";
          version = "0.3.0";
          sha256 = "sha256-mYU6Ivx6CPPjdeI5+/oDxECjmfC3c2UiXqFflv6e1oo=";
          sourceUri = "https://open-vsx.org/api/KylinIdeTeam/kylin-cpp-pack/0.3.0/file/KylinIdeTeam.kylin-cpp-pack-0.3.0.vsix";
        })
      ];
      userSettings = commonSettings // {
        "C_Cpp.default.cppStandard" = "c++20";
        "code-runner.executorMap" = {
          "cpp" = "cd $dir && g++ -O3 -std=c++20 $filename -o $filenameWithoutExt.out && $dir/$filenameWithoutExt.out";
        };
        "code-runner.runInTerminal" = true;
      };
      
      # Bind F5 to run Code Runner
      keybindings = [
        {
          key = "f5";
          command = "code-runner.run";
          when = "editorTextFocus && editorLangId == 'cpp'";
        }
      ];
    };
  };
}