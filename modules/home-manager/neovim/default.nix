{config,pkgs,inputs, ... }:

{

	programs.neovim = {
 		enable = true;
 		defaultEditor = true;
 		viAlias = true;
 		vimAlias = true;

 		# Install plugins here
 		plugins = with pkgs.vimPlugins; [
		  transparent-nvim
 		];

 		# Write your config directly in Nix (for small configs)
 		extraLuaConfig = ''
 		  vim.g.mapleader = " "
			
		  vim.opt.clipboard = "unnamedplus"
		  vim.opt.cmdheight = 0
		  vim.opt.wildmenu = true
		  
		  vim.api.nvim_set_keymap("n", "<leader>il", ":lua ToggelStatusLine()<CR>", {noremap = true, silent = true})

		  require("transparent").setup({
    		  extra_groups = { "NvimTreeNormal", "LspFloatWinNormal" }, 
  		  })

		  function ToggleTabLine()
		  	if vim.o.showtabline == 0 then
				vim.o.showtabline == 2
			else
				vim.o.showtabline == 0
			end
		  end
		  vim.api.nvim_set_keymap("n", "<leader>it", ":lua ToggelTabLine()<CR>", {noremap = true, silent = true})
 		'';
	};

}
