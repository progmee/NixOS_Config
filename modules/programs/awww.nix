{ config, lib, pkgs, inputs, ... }:

let
  # Define the path to the dark wallpaper
  wallpaperPath = ../../assets/wallpapers/dark-nixos.jpg;

  # Create a helper script to set the wallpaper after a short delay
  set-wallpaper = pkgs.writeShellScriptBin "set-wallpaper" ''
    sleep 1
    # Use the awww binary to set the image with a wipe transition
    ${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww img "${wallpaperPath}" --transition-type wipe
  '';
in
{
  home-manager.users.progme = { ... }: {
    # Install awww package for the user
    home.packages = [ 
      inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww 
    ];

    # Systemd service to run the wallpaper setter once on startup
    systemd.user.services.awww-init = {
      Unit = {
        Description = "Initialize wallpaper";
        After = [ "awww.service" ]; # Ensure the daemon starts before setting the image
        PartOf = [ "graphical-session.target" ];
      };
      Service = {
        Type = "oneshot";
        ExecStart = "${set-wallpaper}/bin/set-wallpaper";
      };
      Install = { WantedBy = [ "graphical-session.target" ]; };
    };

    # Systemd service for the awww daemon itself
    systemd.user.services.awww = {
      Unit = {
        Description = "AWWW - Wayland Wallpaper Daemon";
        PartOf = [ "graphical-session.target" ];
        After = [ "graphical-session.target" ];
      };
      Service = {
        ExecStart = "${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww-daemon";
        ExecStop = "${inputs.awww.packages.${pkgs.stdenv.hostPlatform.system}.awww}/bin/awww kill";
        Restart = "on-failure";
      };
      Install = {
        WantedBy = [ "graphical-session.target" ];
      };
    };
  };
}