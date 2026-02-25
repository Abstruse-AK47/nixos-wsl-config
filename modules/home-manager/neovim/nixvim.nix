{configs,pkgs, inputs, ... }: 

{
  # This replaces your old programs.neovim block
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

    globals.mapleader = " ";

    # Options (replaces your vim.opt)
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

    # Plugins (NixVim handles the setups automatically)
    plugins = {
      # Helper plugin to bridge LSP and CMP
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      tmux-navigator.enable = true;


      treesitter = {
          enable = true;
          # Use the pre-packaged grammars from Nixpkgs
          package = pkgs.vimPlugins.nvim-treesitter.withAllGrammars;
          settings = {
            highlight.enable = true;
            indent.enable = true;
          };
      };
      none-ls =  {
        enable = true;
        sources = {
          diagnostics = {
            # Nix linter
            statix.enable = true;
            
            # Python linter (replaces the older flake8/pylint)
            ruff.enable = true; 

            # Shell script linter (if you use bash/sh)
            shellcheck.enable = true;
          };
          
          # Optional: Add formatting here too
          formatting = {
            alejandra.enable = true; # Nix formatter
            ruff.enable = true;      # Python formatter
          };
        };

      telescope = {
        enable = true;
          
        # 1. Enable FZF extension
        extensions = {
          fzf-native.enable = true;
          noice.enable = true;
        };
        
        # 2. Configure Key Mappings and FZF behavior
        settings = {
          defaults = {
            # Use Ctrl+j and Ctrl+k to navigate the results list
            mappings = {
              i = {
                "<C-j>" = "move_selection_next";
                "<C-k>" = "move_selection_previous";
              };
              n = {
                "j" = "move_selection_next";
                "k" = "move_selection_previous";
              };
            };
          };
          
          # Explicitly load FZF as the picker
          # pickers = {
          #   find_files.theme = "dropdown"; # Optional: makes it look even more minimal
          # };
        };
      };
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
            "<C-Space>" = "cmp.mapping.complete()";
            "<Tab>" = "cmp.mapping.confirm({ select = true })";
            "<C-j>" = "cmp.mapping.select_next_item()";
            "<C-k>" = "cmp.mapping.select_prev_item()";
          };
          window = {
            completion.border = "rounded";
            documentation.border = "rounded";
          };
        };
      };
      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      noice = {
        enable = true;
        settings = {
          top_down = false;          
          lsp = {
            override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
            };
          };
          views = {
            cmdline_popup = {
              position = {
                row = "40%";
                col = "50" ;
              };
            };
          };
          presets = {
            bottom_search = false; # Setting this to false keeps search in the middle
            command_palette = true; # Centered HUD style
            long_message_to_split = true;
          };
          routes = [
            {
              filter = {event = "msg_show" ; kind = ""; find = "written";};
              opts = {skip = true; } ;
            }
          ];
        };
      };
        # This is the "Secret Sauce" to center the bar
          views = {
            cmdline_popup = {
              position = {
                row = "40%"; # Centered vertically
                col = "50%"; # Centered horizontally
              };
              size = {
                width = 60;
                height = "auto";
              };
            };
            popupmenu = {
              relative = "editor";
              position = {
                row = "53%"; # Just below the command bar
                col = "50%";
              };
              size = {
                width = 60;
                height = 10;
              };
              border = {
                style = "rounded";
                padding = [ 0 1 ];
              };
          };
        };
      };
    }; 

      mini = {
      enable = true;
      modules.icons = {};
      mockDevIcons = true;
      };
      # Transparency built-in
      transparent = {
        enable = true;
        settings.extra_groups = [ "NormalFloat" "NvimTreeNormal" ];
      };

      # LSP - This is the "Killer Feature" of NixVim
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
        };
      };

    # You can still keep your custom Lua functions if needed
    extraConfigLua = ''
      function ToggleTabLine()
        vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
      end
    '';


    keymaps = [
      { mode = "n"; key = "<leader>nh"; action = ":noh";}
      { mode = "n"; key = "<leader>it"; action = ":lua ToggleTabLine()<CR>"; }
      { mode = "n"; key = "<leader>a"; action = ''<cmd>lua require("harpoon"):list():add()<cr>''; options.desc = "Harpoon: Add file"; }
      { mode = "n"; key = "<C-e>"; action = ''<cmd>lua local harpoon = require("harpoon"); harpoon.ui:toggle_quick_menu(harpoon:list())<cr>''; options.desc = "Harpoon: Quick Menu"; }
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
