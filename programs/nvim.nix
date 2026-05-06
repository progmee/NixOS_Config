# /etc/nixos/programs/nvim.nix

{ pkgs, ... }:

{
  # System-wide neovim installation
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
  };

  # Use Home Manager to inject user-specific configuration
  home-manager.users.progme = { pkgs, ... }: {
    programs.neovim = {
      enable = true;

      # Basic Lua configuration for TTY
      extraLuaConfig = ''
        -- Basic settings
        vim.opt.number = true
        vim.opt.relativenumber = true
        vim.opt.shiftwidth = 2
        vim.opt.expandtab = true
        vim.opt.mouse = 'a'
      '';

      # Plugins managed by Home Manager
      plugins = with pkgs.vimPlugins; [
        nvim-lspconfig
        nvim-cmp
        cmp-nvim-lsp
        luasnip
        (nvim-treesitter.withPlugins (p: [ p.nix p.lua p.vim p.bash ]))
        fzf-vim
      ];
    };
  };

  # System packages required for Neovim intelligence
  environment.systemPackages = with pkgs; [
    nixd
    nixpkgs-fmt
    fzf
  ];
}