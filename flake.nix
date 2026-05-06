# /etc/nixos/flake.nix

{
  description = "NixOS configuration flake with Home Manager";

  inputs = {
    # Using unstable branch for the latest software
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager input following the system nixpkgs version
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # "nixos" matches your networking.hostName
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Main system configuration
        ./configuration.nix

        # Add Home Manager as a module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }
      ];
    };
  };
}