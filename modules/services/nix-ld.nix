{ config, pkgs, ... }:

{
    # Enable nix-ld to provide a standard dynamic linker for non-Nix binaries (like micromamba)
    programs.nix-ld.enable = true;
    programs.nix-ld.libraries = with pkgs; [
        zlib
        stdenv.cc.cc
        openssl
        # Add other common system libraries required by pre-compiled binaries here if needed
    ];
}