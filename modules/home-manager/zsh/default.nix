{config,pkgs, ...}:

{
	# Main zsh config with plugins
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
    	      # disable sort when completing `git checkout`
    	      zstyle ':completion:*:git-checkout:*' sort false
    	      # set descriptions format to enable group support
    	      # NOTE: don't use escape sequences here, fzf-tab will handle them
    	      zstyle ':completion:*:descriptions' format '[%d]'
    	      # set list-colors to enable filename colorizing
    	      zstyle ':completion:*' list-colors ''${(s.:.)LS_COLORS}
    	      # force zsh not to show completion menu, which allows fzf-tab to capture the input
    	      zstyle ':completion:*' menu no
    	     
    	     # CUSTOMIZE FZF-TAB LOOK
    	     # This makes the window much larger (70% of screen) and adds a border
    	     zstyle ':fzf-tab:*' fzf-flags --height=70% --margin=1 --border=rounded --layout=reverse --info=inline
    	     
    	     # # preview directory's content with eza when completing cd
    	     zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
    	   '';
	};
	
	# Zoxide - cd with gps
	programs.zoxide = {
		enable = true;
		enableZshIntegration = true;
		enableBashIntegration = true;
		options = [
			"--cmd cd"
		];
		};
	
	# Atuin for better shell history managment
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

	# oh-my-posh for theme
	programs.oh-my-posh = {
    	enable = true;
    	
    	
    	# If you want to use a specific JSON theme file from your flake or path:
    	settings = builtins.fromJSON (builtins.readFile ./themes/half-life.omp.json);
    	
    	# Or, if you want the "standard" Oh My Posh behavior:
    	enableZshIntegration = true;
  	};

}

