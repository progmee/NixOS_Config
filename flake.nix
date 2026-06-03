{
  # A brief description of this flake
  description = "NixOS configuration with flake";

  # Define external dependencies (repositories) required for the system
  inputs = {
    # The main NixOS repository
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager for user-level package and dotfile management
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim for declarative Neovim configuration
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  # Define the outputs of this flake
  outputs = { self, nixpkgs, home-manager, nixvim, ... }@inputs: {
    
    # Define the configuration for a specific machine named "laptop"
    nixosConfigurations.laptop = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Pass flake inputs into all NixOS modules
      specialArgs = { inherit inputs; };
      
      modules = [
        # The main system configuration file
        ./hosts/laptop/configuration.nix
        
        # Integrate Nixvim and Home Manager
        nixvim.nixosModules.nixvim
        home-manager.nixosModules.home-manager
        
        # System-wide configuration for Home Manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}