{ _ , ... }:

{
  programs.nixvim= {
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
      { mode = "n"; key = "]c"; action = "<cmd>lua require('gitsigns').next_hunk()<CR>"; options.desc = "Next Git Hunk"; }
      { mode = "n"; key = "[c"; action = "<cmd>lua require('gitsigns').prev_hunk()<CR>"; options.desc = "Previous Git Hunk"; }
      { mode = "n"; key = "<leader>gp"; action = "<cmd>lua require('gitsigns').preview_hunk()<CR>"; options.desc = "Preview Git Hunk"; }
    ];    
  };
}
