{ config, pkgs, ... }:

let
  username = "progme";
  secretsPath = /. + "/home/${username}/.nixos-secrets.nix";
  
  secrets = 
    if builtins.pathExists secretsPath 
    then import secretsPath 
    else throw "\n\nError: Secrets file not found!\nPlease create the .nixos-secrets.nix file in /home/${username}\n\n";
in
{
  # Install rclone and fuse3 for mounting
  home.packages = with pkgs; [
    rclone
    fuse3
  ];

  # Declarative rclone configuration file
  xdg.configFile."rclone/rclone.conf".text = ''
    [gdrive]
    type = drive
    scope = drive
    token = ${secrets.rclone-token}
  '';

  # Ensure the mount point directory exists in home
  home.activation.createGoogleDriveFolder = ''
    mkdir -p ~/GoogleDrive
  '';

  # Systemd user service with FULL caching for persistent local storage
  systemd.user.services.rclone-gdrive = {
    Unit = {
      Description = "Rclone mount for Google Drive with full local caching";
      After = [ "network-online.target" ];
      Wants = [ "network-online.target" ];
    };
    Service = {
      Type = "simple";
      # --vfs-cache-mode full: downloads and stores files locally, making them truly offline-available
      # --vfs-cache-max-age: keeps cached files from being deleted too aggressively (e.g. 72h or more)
      ExecStart = ''
        ${pkgs.rclone}/bin/rclone mount gdrive: %h/GoogleDrive \
          --vfs-cache-mode full \
          --vfs-cache-max-age 168h \
          --allow-non-empty
      '';
      ExecStop = "${pkgs.fuse3}/bin/fusermount -u %h/GoogleDrive";
      Restart = "on-failure";
      RestartSec = "10s";
    };
    Install = {
      WantedBy = [ "graphical-session.target" ];
    };
  };
}