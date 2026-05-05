{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix # Specific hardware scan results
    ];

  # Bootloader settings
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network settings
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Localization and Timezone
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  # Nix Package Manager settings
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ]; # Enable Flakes
    auto-optimise-store = true; # Deduplicate files in nix store
  };

  # Automatic Garbage Collection to save disk space
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # GPU / NVIDIA configuration
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Keyboard and Console
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Sound and Input
  security.rtkit.enable = true;
  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
  };
  services.libinput.enable = true;

  # User account configuration
  users.users.progme = {
    isNormalUser = true;
    description = "Default admin user";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh; # Set Zsh as default shell
    
    # User-specific packages
    packages = with pkgs; [
      neovim
      tmux
      eza
      bat
      ripgrep
      git
      btop
      fd
      fastfetch
      starship
      gcc     # Required for Treesitter in Neovim
      gnumake # Common build tool for plugins
    ];
  };

  # System-wide packages
  environment.systemPackages = with pkgs; [
    vim
    git
    wget
    curl
    pciutils
    usbutils
    xdg-utils
    wl-clipboard # Required for Neovim clipboard support
    nil          # Nix Language Server for LSP
    bat-extras.batman   # Required for 'batman' alias
    fzf
    zoxide
  ];

  programs.zoxide = {
    enable = true;
    enableZshIntegration = true;
  };

  # System shell configurations
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  programs.starship.enable = true;
  programs.direnv.enable = true;

  # Useful aliases for daily workflow
  environment.shellAliases = {
    # Zoxide replacement
    cd = "z";

    # System monitoring aliases
    htop = "btop";
    top = "btop";

    # Neovim aliases
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    sv = "sudo -E nvim"; # Preserves the environment and nvim config

    # Fastfetch aliases (using 'ff' to avoid recursion)[cite: 1]
    fetch = "fastfetch --logo none --structure OS:Kernel:Uptime:Packages:Shell:Display:CPU:GPU:Memory:Disk:Break";

    # Batman aliases
    man = "batman";

    # Cat aliases
    cat = "bat --style=plain --pager=never"; 
    preview = "bat --style=numbers,changes,header"; 

    # Eza (ls) aliases
    ls = "eza --icons"; 
    l  = "eza -lbF --git --icons";
    ll = "eza -lbghmuF --git --icons";
    la = "eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons";
    lt = "eza --tree --level=2 --icons";
    tree = "eza --tree --icons";

    # Search and find aliases
    grep = "rg";
    find = "fd";

    # System update shortcut
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
  };

  # Fonts configuration
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];  

  system.stateVersion = "25.11"; # Initial install version
}