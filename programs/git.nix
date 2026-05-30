{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    delta
  ];

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

  systemd.services.fix-nixos-folder-permissions = {
    script = ''
      chown -R progme:users /etc/nixos 
    '';

    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
  };
}
