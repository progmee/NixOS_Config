# /etc/nixos/programs/shell.nix

{ pkgs, ... }:

{
  # Shell configuration
  programs.zsh.enable = true;
  programs.direnv.enable = true;

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
        blue = "#777777"; cyan = "#777777";
        green = "#777777";
        magenta = "#777777"; red = "#777777"; yellow = "#777777";
      };
    };
  };

  # Aliases
  environment.shellAliases = {
    # Zoxide replacement
    cd = "z";

    lg = "lazygit";
    
    # System monitoring aliases
    htop = "btop";
    top = "btop";

    # Neovim aliases
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    sv = "sudo -E nvim"; # Preserves the environment and nvim config

    # Fastfetch aliases (using 'ff' to avoid recursion)
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
    clean = "clear && sudo nix-collect-garbage -d && sudo nix-store --optimize";
  };
}