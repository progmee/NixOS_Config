{
  description = "NixOS configuration flake with Home Manager";

  inputs = {
    # Using unstable branch for the latest software [cite: 35]
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager input following the system nixpkgs version
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    # "nixos" matches your networking.hostName [cite: 3, 37]
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        # Main system configuration [cite: 37]
        ./configuration.nix

        # Add Home Manager as a module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;

          # Define settings for your user
          home-manager.users.progme = { pkgs, ... }: {
            home.stateVersion = "24.11"; # Matching your system stateVersion [cite: 34]
            
            # This is where we will add your user-specific configs
            programs.home-manager.enable = true;
          };
        }
      ];
    };
  };
}