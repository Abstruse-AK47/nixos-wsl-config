{pkgs, ...}:

{

	imports = [
		./modules/home-manager/zsh/default.nix
		./modules/home-manager/fzf/default.nix
		./modules/home-manager/git/default.nix
		./modules/home-manager/tmux/default.nix
		./modules/home-manager/neovim/nixvim.nix
		];
	home = {
    username="nixos";
	  homeDirectory = "/home/nixos";
	  stateVersion = "25.05";
    packages = with pkgs; [
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
    ripgrep
    lazygit
    fd
	(pkgs.writeShellApplication {
	  name = "ns";
	  runtimeInputs = with pkgs; [
	    fzf
	    nix-search-tv
	  ];
	  text = builtins.readFile "${pkgs.nix-search-tv.src}/nixpkgs.sh";
	})
	];
  sessionVariables = {
    EDITOR = "nvim";
    VISUAL = "nvim";
    };
};

}
