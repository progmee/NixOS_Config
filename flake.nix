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

    nixos-wsl.url = "github:nix-community/NixOS-WSL";
  };

  outputs = { self, nixpkgs, home-manager, nixos-wsl, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in
    {
      nixosConfigurations = {
        # Configuration for the physical laptop machine
        laptop = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            ./hosts/laptop/configuration.nix

            # Integrate Home Manager as a NixOS module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.progme = import ./hosts/laptop/home.nix;
            }
          ];
        };

        # Configuration for Windows Subsystem for Linux (WSL)
        wsl = nixpkgs.lib.nixosSystem {
          inherit system;
          modules = [
            nixos-wsl.nixosModules.default # Connect wsl as a module for flake
            ./hosts/wsl/configuration.nix

            # Integrate Home Manager as a NixOS module
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.progme = import ./hosts/wsl/home.nix;
            }
          ];
        };
      };

      # Project development environments (devShells)
      devShells.${system} = {
        web = import ./modules/shells/web.nix { inherit pkgs; };
      };
    };
}