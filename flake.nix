{
  description = "NixOS Flake Configuration with Home-Manager";

  inputs = {
    # Main NixOS unstable channel
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";

    # Home Manager input matching the nixpkgs channel version
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations = {
      laptop = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./hosts/laptop/configuration.nix
          
          # Integrate Home Manager as a NixOS module
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            
            # User-specific configuration for 'progme'
            home-manager.users.progme = import ./hosts/laptop/home.nix;
          }
        ];
      };
    };
  };
}