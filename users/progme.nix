# /etc/nixos/users/progme.nix

{ pkgs, config, ... }:

{
  # User definition
  users.users.progme = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      ghostty git delta eza bat btop fastfetch fd ripgrep fzf lazygit
    ];
  };

  # Home manager
  home-manager.users.progme = { pkgs, ... }: {
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
  };
}