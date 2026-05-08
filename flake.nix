{
  description = "NixOS configuration flake with Hyprland and stunning AMBXST-style UI";

  inputs = {
    # NixOS unstable channel for the latest software and Wayland features
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # Home Manager for user-specific configuration
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Nixvim for Neovim configuration via Nix
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # AGS (Aylur's GTK Shell) - The engine for the stunning UI widgets
    ags.url = "github:aylur/ags";
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ags, ... }@inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      
      # Pass all flake inputs to the module system
      # This allows access to 'inputs.ags' inside nix files
      specialArgs = { inherit inputs; };
      
      modules = [
        # Main system configuration
        ./configuration.nix

        # System-wide Nixvim module
        nixvim.nixosModules.nixvim

        # Enable Home Manager as a module
        home-manager.nixosModules.home-manager
        {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          # Also pass inputs to Home Manager modules
          home-manager.extraSpecialArgs = { inherit inputs; };
        }
      ];
    };
  };
}