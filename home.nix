{config,pkgs, ...}:

{
	home.username="nixos";
	home.homeDirectory = "/home/nixos";
	home.stateVersion = "25.05";
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
		tmux
	(pkgs.writeShellApplication {
	  name = "ns";
	  runtimeInputs = with pkgs; [
	    fzf
	    nix-search-tv
	  ];
	  text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
	}		)
	];

	# Programs

	programs.zsh = {
	    enable = true;
	    enableCompletion = true;
	    autosuggestion.enable = true;
	    syntaxHighlighting.enable = true;
	    autocd = true;
	
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
	   plugins = [
	    {
	      name = "fzf-tab";
	      src = pkgs.fetchFromGitHub {
	        owner = "Aloxaf";
	        repo = "fzf-tab";
	        rev = "v1.1.2"; # Check for the latest version
	        sha256 = "sha256-Qv8zAiMtrr67CbLRrFjGaPzFZcOiMVEFLg1Z+N6VMhg=";
	      };
	    }
	  ];
    	   initContent = ''
    	     # # disable sort when completing `git checkout`
    	     # zstyle ':completion:*:git-checkout:*' sort false
    	     # # set descriptions format to enable group support
    	     # # NOTE: don't use escape sequences here, fzf-tab will handle them
    	     # zstyle ':completion:*:descriptions' format '[%d]'
    	     # # set list-colors to enable filename colorizing
    	     # zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    	     # # force zsh not to show completion menu, which allows fzf-tab to capture the input
    	     # zstyle ':completion:*' menu no
    	     
    	     # CUSTOMIZE FZF-TAB LOOK
    	     # This makes the window much larger (70% of screen) and adds a border
    	     zstyle ':fzf-tab:*' fzf-flags --height=70% --margin=1 --border=rounded --layout=reverse --info=inline
    	     
    	     # # preview directory's content with eza when completing cd
    	     zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    	   '';
	};
	programs.zoxide.enable = true;
	programs.zoxide.enableZshIntegration = true;

	programs.atuin = {
		enable = true;
		enableBashIntegration = true;
		enableZshIntegration = true;

		settings = {
			auto_sync = true;
			sync_frequency = "5m";
			search_mode = "fuzzy";
			filter_mode = "host";
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
