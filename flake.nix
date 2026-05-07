# /etc/nixos/flake.nix

{
  description = "NixOS configuration flake with Home Manager and Nixvim";

  inputs = {
    # Using unstable branch for the latest software
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager input following the system nixpkgs version
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim: Neovim configuration system for Nix
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: {
    # "nixos" matches your networking.hostName
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      # Pass inputs to all modules (required for Nixvim to work properly)
      specialArgs = { inherit inputs; }; 
      
      modules = [
        # Main system configuration
        ./configuration.nix

        # Add Home Manager as a module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
        }

        # Add Nixvim as a system-wide module
        nixvim.nixosModules.nixvim
      ];
    };
  };
}