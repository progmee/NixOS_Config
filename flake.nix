{
  description = "NixOS configuration flake with Hyprland and stunning AMBXST-style UI";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    ambxst.url = "github:Axenide/Ambxst";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    ags.url = "github:aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ags, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Passes flake inputs to all imported modules
      specialArgs = { inherit inputs; };
      
      modules = [
        ./configuration.nix
        nixvim.nixosModules.nixvim
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}