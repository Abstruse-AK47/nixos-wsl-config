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
 		initLua = ''
		  local opt = vim.opt
		  local g = vim.g
 		  g.mapleader = " "
			
		  opt.clipboard = "unnamedplus"
		  opt.cmdheight = 0
		  opt.wildmenu = true
		  opt.relativenumber = true
		  opt.number = true
		  opt.tabstop = 2
		  opt.shiftwidth = 2
		  opt.expandtab = true
		  opt.autoindent = true
		  opt.ignorecase = true
		  opt.smartcase = true
		  opt.cursorline = true

		  opt.fillchars:append({eob = " "})
		  
		  vim.api.nvim_set_keymap("n", "<leader>il", ":lua ToggelStatusLine()<CR>", {noremap = true, silent = true})

		  require("transparent").setup({
			  groups = {
				"Normal",
				"NormalNC",
				"Comment",
				"Constant",
				"Special",
				"Identifier",
				"Statement,
				"PreProc",
				"Underlined",
				"Todo",
				"String"
				"Function",
				"Conditional",
				"Repeat",
				"Operator",
				"Structure",
				"LineNr",
				"NonText",
				"SignCoIumn",
				"CursorLineNr",
				"EndOfBuffer",
				"CursorLine",
				},
			extra_groups = {
				"NormalFloat",
				"NvimTreeNorma1,
				"NvimTreeNorma1NC",
				"NvimTreeNorma1F10at",
				"NvimTreeEndOfBuffer",
				},
			})

		  function ToggleTabLine()
		  	if vim.o.showtabline == 0 then
				vim.o.showtabline = 2
			else
				vim.o.showtabline = 0
			end
		  end
		  vim.api.nvim_set_keymap("n", "<leader>it", ":lua ToggelTabLine()<CR>", {noremap = true, silent = true})
 		'';
	};

}

