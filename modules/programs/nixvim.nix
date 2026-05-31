{ pkgs, ... }:

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    # Basic Vim options
    opts = {
      number = true;
      relativenumber = false;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      mouse = "a";
      termguicolors = false;
    };

    # Essential plugins for TTY
    plugins = {
      fzf-lua.enable = true;

      treesitter = {
        enable = true;
        settings.ensure_installed = [ "nix" "lua" "bash" "vim" ];
      };

      lsp = {
        enable = true;
        servers.nixd.enable = true;
      };

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

    # Keybindings
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