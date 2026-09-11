{ pkgs, ... }:
{
  home.packages = with pkgs; [
    ocaml          # Compilator
    dune_3         # Assembly system
    ocamlPackages.ocaml-lsp # Language server for syntax highlighting
    ocamlPackages.ocamlformat
  ];
}