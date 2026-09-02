{ pkgs }:

pkgs.mkShell {
  buildInputs = [
    (pkgs.python3.withPackages (ps: with ps; [
      fastapi
      uvicorn
    ]))
    pkgs.git
  ];

  shellHook = ''
    echo "Web Development Shell activated!"
  '';
}