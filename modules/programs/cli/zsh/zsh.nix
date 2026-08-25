{ config, pkgs, ... }:

{
  # Enable and configure Zsh via Home Manager
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    # Add Powerlevel10k theme plugin
    plugins = [
      {
        name = "powerlevel10k";
        src = pkgs.zsh-powerlevel10k;
        file = "share/zsh-powerlevel10k/powerlevel10k.zsh-theme";
      }
    ];

    # Disable the aggressive 'no matches found' error for wildcards (like Bash)
    # and source the p10k configuration file
    initContent = ''
      setopt +o nomatch

      # Source Powerlevel10k configuration
      [[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
    '';
  };

  # Link the .p10k.zsh config cleanly from the assets folder using builtins.readFile
  home.file.".p10k.zsh".text = builtins.readFile ../../../../assets/p10k.zsh;

  # Enable direnv for environment management (with nix-direnv integration)
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}