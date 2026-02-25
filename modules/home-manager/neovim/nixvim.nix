{ configs, pkgs, inputs, ... }: 

{
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";

    opts = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      clipboard = "unnamedplus";
      cmdheight = 0;
      laststatus = 0;
    };

    plugins = {
      # Completion Engine
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "cmdline"; }
          ];
          mapping = {
            "<C-Space>" = config.lib.nixvim.mkRaw "cmp.mapping.complete()";
            "<Tab>" = config.lib.nixvim.mkRaw "cmp.mapping.confirm({ select = true })";
            "<C-j>" = config.lib.nixvim.mkRaw "cmp.mapping.select_next_item()";
            "<C-k>" = config.lib.nixvim.mkRaw "cmp.mapping.select_prev_item()";
          };
          window = {
            completion.border = "rounded";
            documentation.border = "rounded";
          };
        };
      };

      # Completion Helpers
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp-cmdline.enable = true;
      luasnip.enable = true;

      # Treesitter - Fixed typo 'nixGrammer' -> 'nixGrammars'
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Search & Navigation
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          noice.enable = true;
        };
        settings.defaults.mappings.i = {
          "<C-j>" = "move_selection_next";
          "<C-k>" = "move_selection_previous";
        };
      };

      # Harpoon
      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      # UI & HUD
      noice = {
        enable = true;
        settings = {
          top_down = false; 
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
          presets = {
            bottom_search = false;
            command_palette = true;
            long_message_to_split = true;
          };
          # Centered UI placement
          views = {
            cmdline_popup = {
              position = { row = "40%"; col = "50%"; };
              size = { width = 60; height = "auto"; };
            };
            popupmenu = {
              relative = "editor";
              position = { row = "53%"; col = "50%"; };
              size = { width = 60; height = 10; };
              border = { style = "rounded"; padding = [ 0 1 ]; };
            };
          };
        };
      };

      # Notification base
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000"; # Renamed and moved inside settings
          fps = 60;
          render = "minimal";
          stages = "fade";
          timeout = 2000;
        };
      };      

      # Quality of Life
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      tmux-navigator.enable = true;
      mini = {
        enable = true;
        modules.icons = {};
        mockDevIcons = true;
      };

      transparent = {
        enable = true;
        settings.extra_groups = [ 
          "NormalFloat" 
          "NvimTreeNormal" 
          "TelescopeNormal" 
          "TelescopeBorder"
        ];
      };

      # Linting & Formatting
      none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            statix.enable = true;
            ruff.enable = true;
            shellcheck.enable = true;
          };
          formatting = {
            alejandra.enable = true;
            ruff.enable = true;
          };
        };
      };

      # LSP
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
        };
      };
    };

    extraConfigLua = ''
      function ToggleTabLine()
        vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
      end
    '';

    keymaps = [
      { mode = "n"; key = "<leader>nh"; action = ":noh<CR>"; }
      { mode = "n"; key = "<leader>it"; action = ":lua ToggleTabLine()<CR>"; }
      { mode = "n"; key = "<leader>a";  action = ''<cmd>lua require("harpoon"):list():add()<cr>''; options.desc = "Harpoon: Add file"; }
      { mode = "n"; key = "<C-e>";     action = ''<cmd>lua local harpoon = require("harpoon"); harpoon.ui:toggle_quick_menu(harpoon:list())<cr>''; options.desc = "Harpoon: Quick Menu"; }
      { mode = "n"; key = "<leader>d";  action = ":lua vim.diagnostic.open_float()<CR>"; options = { silent = true; desc = "Line Diagnostics"; }; }
      { mode = "n"; key = "<leader>D";  action = ":Telescope diagnostics bufnr=0<CR>"; options = { silent = true; desc = "Buffer Diagnostics"; }; }
      { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<CR>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = ":Telescope live_grep<CR>"; options.desc = "Live Grep"; } 
      { mode = "n"; key = "<leader>fo"; action = ":Telescope oldfiles<CR>"; options.desc = "Recent Files"; }
      { mode = "n"; key = "<leader>fc"; action = ":Telescope grep_string<CR>"; options.desc = "Find word under cursor"; }
      { mode = "n"; key = "<leader>fn"; action = "<cmd>Telescope noice<CR>"; options.desc = "Find Notifications (Noice)"; }
      { mode = "n"; key = "<leader>nd"; action = "<cmd>NoiceDismiss<CR>"; options.desc = "Dismiss Noice Message"; }
    ];  
  };
}
