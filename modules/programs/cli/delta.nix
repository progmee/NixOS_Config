{ config, pkgs, ... }:

{
  # Enable and configure delta as a syntax-highlighting pager for git diffs
  programs.delta = {
    enable = true;
    options = {
      side-by-side = true;
      navigate = true;
    };
  };
}