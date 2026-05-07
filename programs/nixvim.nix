# /etc/nixos/programs/nixvim.nix

{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Basic Vim options (your preferences)
    opts = {
      number = true; 
      relativenumber = false;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      mouse = "a";
      termguicolors = false;
    };

    # Theme: No-Clown-Fiesta
    colorschemes.no-clown-fiesta = {
      enable = true;
      settings = {
        transparent = false;
        styles = {
          comments = { italic = false; };
          keywords = { bold = true; };
          functions = { bold = true; };
        };
      };
    };

    # Plugins
    plugins = {
      # Syntax highlighting
      treesitter = {
        enable = true;
        settings.ensure_installed = [ "nix" "lua" "bash" "vim" ];
      };

      # LSP (Intelligence)
      lsp = {
        enable = true;
        servers = {
          nixd.enable = true; # Nix language server
        };
      };

      # Auto-completion
      cmp = {
        enable = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
          ];
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
            "<Tab>" = "cmp.mapping.select_next_item()";
            "<S-Tab>" = "cmp.mapping.select_prev_item()";
          };
        };
      };
    };

    # Keymaps
    globals.mapleader = " ";
    keymaps = [
      {
        mode = "n";
        key = "<leader>ff";
        action = "<cmd>FzfLua files<cr>";
        options.desc = "Find Files";
      }
    ];
  };
}