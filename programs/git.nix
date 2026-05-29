{ pkgs, ... }:

{
  programs.git = {
    enable = true;

    config = {
      user = {
        name = "Aleksadr";
        email = "progme.contact@gmail.com";
      };

      safe = {
        directory = "/etc/nixos";
      };

      core = {
        editor = "nvim";
      };

      init = {
        defaultBranch = "main";
      };

      pull = {
        rebase = true;
      };
    };
  };
}
