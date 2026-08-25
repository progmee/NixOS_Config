{ pkgs, ... }:

let
  # Definition of the Win11 icon theme derivation
  win11Icons = pkgs.stdenv.mkDerivation {
    pname = "win11-icon-theme";
    version = "master";

    # Source code of the icon theme fetched from GitHub
    src = pkgs.fetchurl {
      url = "https://github.com/yeyushengfan258/Win11-icon-theme/archive/refs/heads/master.tar.gz";
      hash = "sha256-QQBY2P2gt3lHDq24sU91E64GvzlfGhYRnhgF2oavsx0=";
    };

    # Disable the default fixup phase to prevent errors with relative symlinks
    dontFixup = true;
    
    # Required tools for the installation script inside the sandbox
    nativeBuildInputs = [ pkgs.bash pkgs.gtk3 ];

    # Installation phase: prepare directories, patch shebangs, and run the install script
    installPhase = ''
      mkdir -p $out/share/icons
      patchShebangs .
      ./install.sh -d $out/share/icons
    '';
  };
in
{
  # Make the icon package available in the user profile
  home.packages = [
    win11Icons
  ];
}