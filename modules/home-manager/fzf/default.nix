{config,pkgs, ...}:

{

	programs.fzf = {
	  enable = true;
	  enableBashIntegration = true;
	  enableZshIntegration = true;
	  # This sets the layout globally for all fzf commands (Ctrl-T, Alt-C, etc.)
	  defaultOptions = [
	    "--layout=reverse"
	    "--border=rounded"
	    "--margin=1"
	    "--padding=1"
	    "--height=100%"
	    "--marker='*'"
	    "--color='header:italic,info:dim'"
	    "--header-first"
	    "--preview-window='right:60%:border-left'"
	  ];
	};
}
