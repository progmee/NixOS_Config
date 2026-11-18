{ pkgs }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.python3.withPackages (ps: with ps; [
      fastapi
      uvicorn
    ]))
    pkgs.git
    pkgs.php                                   # PHP interpreter for web development
    pkgs.phpPackages.composer                  # Dependency manager for PHP (Composer)
  ];

  shellHook = ''
    echo "Web Development Shell activated!"
  '';
}