{ config, ... }:

let
  username = "progme"; # Change this to your username
  secretsPath = /. + "/home/${username}/.nixos-secrets.nix";
  
  secrets = 
    if builtins.pathExists secretsPath 
    then import secretsPath 
    else throw "\n\nError: Secrets file not found!\nPlease create the .nixos-secrets.nix file in /home/${username}\n\n";
in
{
  # Enable NetworkManager for network management
  networking.networkmanager.enable = true;

  networking.networkmanager.ensureProfiles.profiles = {
    "Livebox-B210" = {
      connection = {
        id = "Livebox-B210";
        type = "wifi";
        autoconnect = true;
      };
      wifi = {
        ssid = "Livebox-B210";
        mode = "infrastructure";
      };
      wifi-security = {
        key-mgmt = "wpa-psk";
        psk = secrets.home-wifi-password;
      };
    };
  };
}