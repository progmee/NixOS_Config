{ pkgs, ... }:

{
  networking = {
    hostName = "nixos";
    
    networkmanager.enable = true;
    
    networkmanager.ensureProfiles.profiles = {
      "Home-WiFi" = {
        connection = {
          id = "Home-WiFi";
          type = "wifi";
          autoconnect = true;
        };

        wifi = {
          mode = "infrastructure";
          ssid = "Livebox-B210";
        };

        wifi-security = {
          auth-alg = "open";
          key-mgmt = "wpa-psk";
          psk = "5jqF2q7HoQbLjr6uvx";
        };
      };
    };
  };
}
