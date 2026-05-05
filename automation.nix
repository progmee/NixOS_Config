# automation.nix
{ pkgs, ... }:

{
  # Sudo rules for passwordless rebuild
  security.sudo.extraRules = [{
    users = [ "progme" ];
    commands = [
      { command = "/run/current-system/sw/bin/nixos-rebuild"; options = [ "NOPASSWD" ]; }
    ];
  }];

  # Systemd service to sync config from Git
  systemd.services.nixos-git-sync = {
    description = "Sync NixOS config with github";
    path = with pkgs; [ git openssh nixos-rebuild sudo coreutils ];
    serviceConfig = {
      Type = "oneshot";
      User = "progme";
      ExecStart = "/etc/nixos/update.sh";
    };
  };

  # Timer for periodic Git sync[cite: 1]
  systemd.timers.nixos-git-sync = {
     wantedBy = [ "timers.target" ];
     timerConfig = {
       OnBootSec = "1m";
       OnUnitActiveSec = "1m";
       Unit = "nixos-git-sync.service";
     };
  };
}