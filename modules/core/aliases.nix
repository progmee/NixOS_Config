{ pkgs, config, ... }:
{
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

    # System update shortcut
    rebuild = "sudo nixos-rebuild switch --flake /etc/nixos#laptop";
    clean = "clear && sudo nix-collect-garbage -d && sudo nix-store --optimize";
  };
}
