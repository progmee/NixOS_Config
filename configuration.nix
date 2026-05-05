{ config, lib, pkgs, ... }:

{
  imports =
    [ 
      ./hardware-configuration.nix # Specific hardware scan results[cite: 1]
      ./automation.nix
    ];

  # Bootloader settings[cite: 1]
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  # Network settings[cite: 1]
  networking.hostName = "nixos";
  networking.networkmanager.enable = true;

  # Localization and Timezone[cite: 1]
  time.timeZone = "Europe/Paris";
  i18n.defaultLocale = "en_US.UTF-8";
  i18n.supportedLocales = [
    "en_US.UTF-8/UTF-8"
    "ru_RU.UTF-8/UTF-8"
  ];

  # Nix Package Manager settings[cite: 1]
  nixpkgs.config.allowUnfree = true;
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ]; # Enable Flakes[cite: 1]
    auto-optimise-store = true; # Deduplicate files in nix store
  };

  # Automatic Garbage Collection to save disk space
  nix.gc = {
    automatic = true;
    dates = "weekly";
    options = "--delete-older-than 7d";
  };

  # GPU / NVIDIA configuration[cite: 1]
  hardware.graphics.enable = true;
  services.xserver.videoDrivers = ["nvidia"];
  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = false;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  # Keyboard and Console[cite: 1]
  services.xserver.xkb = {
    layout = "us,ru";
    options = "grp:alt_shift_toggle";
  };
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  # Sound and Input[cite: 1]
  security.rtkit.enable = true;
  services.pipewire = {
     enable = true;
     alsa.enable = true;
     alsa.support32Bit = true;
     pulse.enable = true;
  };
  services.libinput.enable = true;

  # User account configuration[cite: 1]
  users.users.progme = {
    isNormalUser = true;
    description = "Default admin user";
    extraGroups = [ "networkmanager" "wheel" "video" "audio" ];
    shell = pkgs.zsh; # Set Zsh as default shell
    
    # User-specific packages[cite: 1]
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

  # System-wide packages[cite: 1]
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
  ];

  # System shell configurations
  programs.zsh.enable = true;
  programs.starship.enable = true;
  programs.direnv.enable = true;

  # Useful aliases for daily workflow
  environment.shellAliases = {
    # System monitoring aliases
    htop = "btop";
    top = "btop";

    # Neovim aliases
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    sv = "sudo -E nvim"; # Preserves an envirement and nvim config

    # Fastfetch alias
    fastfetch = "fastfetch --logo none";
    fetch = "fastfetch --logo none";

    # Batman aliases
    man = "batman";

    # Cat aliases
    cat = "bat --style=plain --pager=never"; # Plain output like cat but with colors
    preview = "bat --style=numbers,changes,header"; # Rich output with line numbers and git changes

    # Exa aliases
    ls = "eza --icons"; 
    l  = "eza -lbF --git --icons";
    ll = "eza -lbghmuF --git --icons";
    la = "eza -lbhHigUmuSa --time-style=long-iso --git --color-scale --icons";
    lt = "eza --tree --level=2 --icons";
    tree = "eza --tree --icons";

    # Ripgrep aliases
    grep = "rg";

    # Fast find alias
    find = "fd";

    # System update shortcut
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#nixos";
  };

  # Fonts[cite: 1]
  fonts.packages = with pkgs; [
    nerd-fonts.jetbrains-mono
  ];  

  system.stateVersion = "25.11"; # Initial install version[cite: 1]
}