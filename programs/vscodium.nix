{ pkgs, config, ... }:

{
  home-manager.users.progme = {
    home.stateVersion = "24.11"; 

    home.packages = with pkgs; [
      (vscode-with-extensions.override {
        vscode = vscodium;
        vscodeExtensions = with vscode-extensions; [
          jnoortheen.nix-ide
          vscode-icons-team.vscode-icons
        ];
      })
    ];
  };
}
