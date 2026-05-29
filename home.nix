{ pkgs, config, ... }:

{
  # User definition
  users.users.progme = {
    isNormalUser = true;
    description = "progme";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      ghostty git delta eza bat btop fastfetch fd ripgrep fzf lazygit
    ];

    hashedPassword = "$6$GYG6akJc/DQ7lOHT$93RM5rygD.H4odRI02fOjRT1m71yqWMCsy9jYjU.iPa7mh/Bur3JE.DGbhu2Nb6uEbtYodKO/ADt3R5K7BA.i.";
  };

  # Home manager
  home-manager.users.progme = { pkgs, ... }: {
    home.stateVersion = "24.11";
    programs.home-manager.enable = true;
  };
}
