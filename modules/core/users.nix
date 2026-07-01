{ pkgs, config, ... }:

{
  # User definition
  users.users.progme = {
    isNormalUser = true;
    description = "progme";
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      ghostty
    ];

    hashedPassword = "$6$GYG6akJc/DQ7lOHT$93RM5rygD.H4odRI02fOjRT1m71yqWMCsy9jYjU.iPa7mh/Bur3JE.DGbhu2Nb6uEbtYodKO/ADt3R5K7BA.i.";
  };

  environment.systemPackages = with pkgs; [
    eza bat btop fastfetch fd ripgrep fzf lazygit bat-extras.batman zip unzip
  ];
}
