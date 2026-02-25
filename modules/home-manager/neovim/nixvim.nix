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

      noice = {
        enable = true;
        settings.presets = {
          bottom_search = true;
          command_pallet = true;
          long_message_to_split = true;
        };
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
    ];
  };
}
