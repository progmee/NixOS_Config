{ config, pkgs, ... }:
{
    # Enable nix-ld compatibility tool for NixOS
    programs.nix-ld.enable = true;

    systemd.targets.user-daemon = {
      wants = [ "user@progme.service" ];
      wantedBy = [ "multi-user.target" ];
    };
}
