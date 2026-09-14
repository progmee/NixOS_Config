{ config, pkgs, ... }:

{
  # Ensure NetworkManager is enabled for the dispatcher script to work
  networking.networkmanager.enable = true;

  # Enable Samba service permanently with subnet restrictions
  services.samba = {
    enable = true;
    settings = {
      global = {
        "workgroup" = "WORKGROUP";
        "server string" = "NixOS Laptop";
        "netbios name" = "nixos-laptop";
        "security" = "user";
        
        # Allow access only from the home subnet and localhost, deny everything else
        "hosts allow" = "192.168.1. 127.0.0.1";
        "hosts deny" = "0.0.0.0/0";
      };
      homes = {
        "comment" = "Home Directories";
        "browseable" = "yes";
        "read only" = "no";
        "create mask" = "0700";
        "directory mask" = "0700";
      };
    };
  };

  # Network discovery service (WSD) for Windows Explorer visibility, disabled by default
  services.samba-wsdd = {
    enable = false;
    openFirewall = true;
  };

  # Open standard ports for Samba and network discovery
  networking.firewall.allowedTCPPorts = [ 445 139 ];
  networking.firewall.allowedUDPPorts = [ 137 138 ];

  # NetworkManager dispatcher script to toggle WSD visibility based on active Wi-Fi SSID
  networking.networkmanager.dispatcherScripts = [
    {
      source = pkgs.writeShellScript "samba-home-switch" ''
        interface="$1"
        action="$2"

        # Fetch the active Wi-Fi SSID
        current_ssid=$(nmcli -t -f active,ssid dev wifi | grep '^yes' | cut -d: -f2)
        home_ssid="Livebox-B210"

        if [ "$current_ssid" = "$home_ssid" ]; then
          if [ "$action" = "up" ]; then
            systemctl start wsdd
          fi
        else
          if [ "$action" = "down" ] || [ "$action" = "up" ]; then
            systemctl stop wsdd
          fi
        fi
      '';
    }
  ];
}