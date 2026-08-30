{ config, pkgs, ... }:

{
  # Shell aliases configuration for Zsh
  programs.zsh.shellAliases = {
    # Zoxide replacement for standard cd
    cd = "z";

    # Git interface alias
    lg = "lazygit";

    # System monitoring aliases
    htop = "btop";
    top = "btop";

    # Neovim shortcuts and root privileges environment preservation
    v = "nvim";
    vi = "nvim";
    vim = "nvim";
    sv = "sudo -E nvim";

    # Fastfetch custom layout configuration
    fetch = "fastfetch --logo none --structure OS:Kernel:Uptime:Packages:Shell:Display:CPU:GPU:Memory:Disk:Break";

    # Batman (bat-powered man pages) integration alias
    man = "batman";

    # Bat (cat replacement) formatting configurations
    cat = "bat --style=plain --pager=never";
    preview = "bat --style=numbers,changes,header";

    # Eza (modern ls replacement) aliases with icons and formatting
    ls = "eza --icons=always";
    l  = "eza -lbF --git --icons=always";
    ll = "eza -lbghmuF --git --icons=always";
    lt = "eza --tree --level=2 --icons=always";
    tree = "eza --tree --icons=always";

    # Ripgrep search replacement for grep
    grep = "rg";

    # System maintenance and update shortcuts
    rebuild = "sudo nixos-rebuild switch --flake ~/.nixos-config#$(hostname) --impure";
    clean = "clear && sudo nix-collect-garbage -d && sudo nix-store --optimize";

    # Simple alias to list and filter shell aliases
    sal = "alias | command grep -i";
  };
}
