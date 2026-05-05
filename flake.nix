{
  description = "NixOS configuration flake with auto-sync";

  inputs = {
    # Using unstable branch for the latest software and Neovim plugins[cite: 2]
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
  };

  outputs = { self, nixpkgs }: {
    # "nixos" must match your networking.hostName[cite: 1, 2]
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
         ./configuration.nix
      ];
    };
  };
}