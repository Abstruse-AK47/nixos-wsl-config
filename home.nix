{config,pkgs,inputs, ...}:

{

	imports = [
		./modules/home-manager/zsh/default.nix
		./modules/home-manager/fzf/default.nix
		./modules/home-manager/git/default.nix
		./modules/home-manager/tmux/default.nix
		./modules/home-manager/neovim/default.nix
		];
	home.username="nixos";
	home.homeDirectory = "/home/nixos";
	home.stateVersion = "25.05";
  home.packages = with pkgs; [
		git 
		cudaPackages.cudatoolkit
		wget
		eza
		pciutils
		yazi
		fzf
		gawk
		bat
		xdg-utils
		wl-clipboard
		wslu
	(pkgs.writeShellApplication {
	  name = "ns";
	  runtimeInputs = with pkgs; [
	    fzf
	    nix-search-tv
	  ];
	  text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
	})
	];

  home.sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
}
