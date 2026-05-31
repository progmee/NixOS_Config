{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    google-chrome
  ];

  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
  };
}
