{config,pkgs, ...}:

{
	home.username="nixos";
	home.homeDirectory = "/home/nixos";
	home.stateVersion = "25.05";
	programs.zsh = {
	    enable = true;
	    enableCompletion = true;
	    autosuggestion.enable = true;
	    syntaxHighlighting.enable = true;
	
	    shellAliases = {
	      update = "sudo nixos-rebuild switch --flake .";
	      ll = "ls -l";
	      z = "eza --icons=always -a";
	      garbage = "nix-collect-garbage -d";
	    };
	
	    history = {
	      size = 10000;
	      path = "${config.xdg.dataHome}/zsh/history";
	    };
	  };	

	programs.oh-my-posh = {
    	enable = true;
    	
    	# You can choose a built-in theme or point to a local file
    	# useTheme = "jfeliva"; 
    	
    	# If you want to use a specific JSON theme file from your flake or path:
    	settings = builtins.fromJSON (builtins.readFile ./themes/half-life.omp.json);
    	
    	# Or, if you want the "standard" Oh My Posh behavior:
    	enableZshIntegration = true;
  	};

	programs.delta = {
		enable = true;
		enableGitIntegration = true;
		};

	programs.git = {
		enable = true;

		settings = {
			user = {
			name = "AK";
			email = "ayan344kapil@gmail.com";
		};

		init = {
			defaultBranch = "main";
			};
		pull = {
			rebase = true;
			};
		};
	};
	        

  	home.packages = with pkgs; [
		neovim
		git 
		cudaPackages.cudatoolkit
		wget
		eza
		pciutils
		yazi
		fzf
		bat
	(pkgs.writeShellApplication {
	  name = "ns";
	  runtimeInputs = with pkgs; [
	    fzf
	    nix-search-tv
	  ];
	  text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
	}		)
	];
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
