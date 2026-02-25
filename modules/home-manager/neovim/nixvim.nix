{configs,pkgs, inputs, ... }: 

{
  # This replaces your old programs.neovim block
  programs.nixvim = {
    enable = true;
    defaultEditor = true;

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

      notify.enable = true;

      noice = {
        enable = true;
        backgroundColor = "#000000";
        fps = 60;
        render = "minimal";
        stages = "fade";
        timeout = 2000;
        settings.presets = {
          bottom_search = true;
          command_palette = true;
          long_message_to_split = true;
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
      { mode = "n"; key = "<leader>a"; action = ":lua require('harpoon.mark').add_file()<CR>"; }
      { mode = "n"; key = "<C-e>"; action = ":lua require('harpoon.ui').toggle_quick_menu()<CR>"; }
      { mode = "n"; key = "<leader>d"; action = ":lua vim.diagnostic.open_float()<CR>"; options = { silent = true; desc = "Line Diagnostics"; };}
      { mode = "n"; key = "<leader>D"; action = ":Telescope diagnostics bufnr=0<CR>"; options = { silent = true; desc = "Buffer Diagnostics (Telescope)";};}
    ];
  };
}
