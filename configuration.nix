{ config, lib, pkgs, ... }:

{
  imports = [ 
    ./hardware-configuration.nix 
  ];

  # Bootloader
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Localization
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [ "en_US.UTF-8/UTF-8" "ru_RU.UTF-8/UTF-8" ];

  # Nix settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    auto-optimise-store = true;
  };

  # GC settings
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # GPU / NVIDIA
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    open = false;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Shell configuration
  programs.zsh.enable = true;
  programs.direnv.enable = true;

  # User definition
  users.users.progme = {
    isNormalUser = true;
    shell = pkgs.zsh;
    extraGroups = [ "networkmanager" "wheel" "video" ];
    packages = with pkgs; [
      neovim ghostty git delta eza bat btop fastfetch fd ripgrep fzf
    ];
  };

  # Aliases
  environment.shellAliases = {
    v = "nvim";
    lg = "lazygit";
    ls = "eza --icons";
    ll = "eza -lbghmuF --git --icons";
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
    fresh = "clear && sudo nix-collect-garbage -d && sudo nix-store --optimize";
  };

  # Home manager
  home-manager.users.progme = { pkgs, ... }: {
    home.stateVersion = "24.11";
    
    programs.home-manager.enable = true;
  };

  # Starship (System-wide for now)
  programs.starship = {
    enable = true;
    settings = {
      palette = "grey";
      format = "$username$hostname$directory$fill$cmd_duration$time$line_break$character";
      character = {
        success_symbol = "[@](bold green)";
        error_symbol = "[@](bold red)";
      };
      fill = { symbol = "─"; style = "#222222"; };
      palettes.grey = {
        grey = "#777777";
        blue = "#777777"; cyan = "#777777"; green = "#777777";
        magenta = "#777777"; red = "#777777"; yellow = "#777777";
      };
    };
  };

  # Fonts
  fonts.packages = with pkgs; [ 
    nerd-fonts.jetbrains-mono 
  ];

  system.stateVersion = "24.11";
}