{ pkgs, ... }:

{
  # Install qBittorrent (lightweight BitTorrent client)
  home.packages = [
    pkgs.qbittorrent
  ];
}