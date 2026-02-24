{config,pkgs, ...}:

{

	imports = [
		./modules/home-manager/zsh/default.nix
		./modules/home-manader/fzf/default.nix
		./modules/home-manager/git/default.nix
		];
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
}
