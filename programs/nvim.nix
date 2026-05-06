# /etc/nixos/programs/nvim.nix

{ pkgs, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;

    # Basic plugins for configuration assistance
    plugins = with pkgs.vimPlugins; [
      # LSP and Completion engines
      nvim-lspconfig
      nvim-cmp
      cmp-nvim-lsp
      luasnip
      
      # Syntax highlighting
      (nvim-treesitter.withPlugins (p: [ p.nix p.lua p.vim p.bash ]))

      # Navigation
      fzf-vim
    ];

    # Empty configuration for manual setup
    extraLuaConfig = ''
      -- Basic settings
      vim.opt.number = true
      vim.opt.relativenumber = true
      vim.opt.shiftwidth = 2
      vim.opt.expandtab = true
      vim.opt.mouse = 'a'
    '';
  };
}