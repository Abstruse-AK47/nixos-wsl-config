{pkgs, ...}:

{

	imports = [
		./modules/home-manager/zsh/default.nix
		./modules/home-manager/fzf/default.nix
		./modules/home-manager/git/default.nix
		./modules/home-manager/tmux/default.nix
		./modules/home-manager/neovim/nixvim.nix
    ./modules/home-manager/direnv/default.nix
		];

  # --- CRITICAL HASSLE-FREE LINKER FIX ---
  # This forces unpatched PyPI wheels (like OpenCV/NumPy) to find their missing dependencies
  programs.nix-ld = {
    enable = true;
    libraries = with pkgs; [
      stdenv.cc.cc.lib       # Fixes libstdc++.so.6 (NumPy)
      zlib                   # Fixes libz.so.1
      glib                   # Fixes libglib (OpenCV)
      libGL                  # Fixes libGL (OpenCV graphics rendering)
      ffmpeg_4               # Fixes libavcodec.so.58 (OpenCV video decoding)
      cudaPackages.cudatoolkit # Fixes libcufft.so.12 & libcublas.so.12 system-wide
    ];
  };

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
    devenv
    stdenv.cc.cc.lib
    zlib
    glib
    libGL
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
