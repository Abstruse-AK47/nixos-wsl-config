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

      treesitter.enable = true;
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      tmux-navigator.enable = true;
      telescope.enable = true;

      harpoon = {
        enable = true;
        enableTelescope = true;
      };

      noice = {
        enable = true;
        settings = {
          presets = {
            bottom_search = false; # Setting this to false keeps search in the middle
            command_palette = true; # Centered HUD style
            long_message_to_split = true;
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
          python_ls.enable = true;
        };
      };
    };

    # You can still keep your custom Lua functions if needed
    extraConfigLua = ''
      function ToggleTabLine()
        vim.o.showtabline = vim.o.showtabline == 0 and 2 or 0
      end
    '';


    keymaps = [
      { mode = "n"; key = "<leader>it"; action = ":lua ToggleTabLine()<CR>"; }
      { mode = "n"; key = "<leader>a"; action = ''<cmd>lua require("harpoon"):list():add()<cr>''; options.desc = "Harpoon: Add file"; }
      { mode = "n"; key = "<C-e>"; action = ''<cmd>lua local harpoon = require("harpoon"); harpoon.ui:toggle_quick_menu(harpoon:list())<cr>''; options.desc = "Harpoon: Quick Menu"; }
      { mode = "n"; key = "<leader>d";  action = ":lua vim.diagnostic.open_float()<CR>"; options = { silent = true; desc = "Line Diagnostics"; }; }
      { mode = "n"; key = "<leader>D";  action = ":Telescope diagnostics bufnr=0<CR>"; options = { silent = true; desc = "Buffer Diagnostics"; }; }
      { mode = "n"; key = "<leader>ff"; action = ":Telescope find_files<CR>"; options.desc = "Find Files"; }
      { mode = "n"; key = "<leader>fg"; action = ":Telescope live_grep<CR>"; options.desc = "Live Grep"; } 
      { mode = "n"; key = "<leader>fo"; action = ":Telescope oldfiles<CR>"; options.desc = "Recent Files"; }
      { mode = "n"; key = "<leader>fc"; action = ":Telescope grep_string<CR>"; options.desc = "Find word under cursor"; }
    ];  
  };
}
