{ config, pkgs, ... }:
{
    # Fix VSCodium user launch service on WSL
    systemd.targets.user-daemon = {
      wants = [ "user@progme.service" ];
      wantedBy = [ "multi-user.target" ];
    };
}