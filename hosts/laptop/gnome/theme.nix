{ pkgs, ... }:

let
  # Definition of the Fluent GTK theme derivation
  fluentTheme = pkgs.stdenv.mkDerivation {
    pname = "fluent-gtk-theme";
    version = "master";

    # Source code of the Fluent GTK theme fetched from GitHub
    src = pkgs.fetchurl {
      url = "https://github.com/vinceliuice/Fluent-gtk-theme/archive/refs/heads/master.tar.gz";
      hash = "sha256-3ih4AkVXsmv2Sc8JTtfpZAxsO6NNwA8XsHftZ7dWNQw=";
    };

    # Disable the default fixup phase to prevent unexpected modifications or errors
    dontFixup = true;
    
    # Required tools and dependencies for the installation script inside the sandbox
    nativeBuildInputs = [ pkgs.bash pkgs.gtk3 ];

    # Installation phase: prepare the themes directory, patch shebangs, and run the install script
    installPhase = ''
      mkdir -p $out/share/themes
      patchShebangs .

      # Execute the official installation script targeting our output directory
      ./install.sh -d $out/share/themes
    '';
  };
in
{
  # Make the Fluent theme package, extra GNOME themes, and utilities available in the user profile
  home.packages = [
    fluentTheme
    pkgs.gnome-themes-extra
  ];
}