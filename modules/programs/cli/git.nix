{ config, pkgs, ... }:

{
  # Enable and configure Git via Home Manager
  programs.git = {
    enable = true;

    settings = {
      user = {
        name = "Aleksandr";
        email = "progme.contact@gmail.com";
      };

      # Mark /etc/nixos as a safe directory to avoid ownership complaints
      safe = {
        directory = "/etc/nixos";
      };

      # Set Neovim as the default text editor for Git operations
      core = {
        editor = "micro";
      };

      # Use 'main' as the default branch name for new repositories
      init = {
        defaultBranch = "main";
      };

      # Automatically rebase local commits on top of fetched branches when pulling
      pull = {
        rebase = true;
      };
    };

    # Git command aliases for fast and efficient workflow
    settings.aliases = {
      st = "status";          # git st -> git status
      co = "checkout";        # git co -> git checkout
      br = "branch";          # git br -> git branch
      ci = "commit";          # git ci -> git commit
      unstage = "reset HEAD"; # git unstage <file> -> unstage file
      last = "log -1 HEAD";   # git last -> show the last commit
      lg = "log --color --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr) <%an>%Creset' --abbrev-commit"; # Pretty commit graph
    };
  };
}