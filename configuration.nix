{config,lib, pkgs, ... }:

{

  imports = [
  	./modules/nvidia.nix
  ];
  # 1. WSL Specifics
  wsl.enable = true;
  wsl.defaultUser = "nixos"; 
  wsl.useWindowsDriver = true;

  # 2. The "Must-Haves" for CUDA
  nixpkgs.config.allowUnfree = true;

  programs.zsh.enable = true;

  # 2. Set it as the default shell for your user
  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };
  

  # zramSwap.enable = true;
  # zramSwap.memoryPercent = 50;
  # zramSwap.algorithm = "zstd";
  programs.nix-ld.enable = true;

  hardware.graphics.enable=true;

  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];


  # 2. Provide the libraries that nvidia-smi and CUDA apps usually need
  programs.nix-ld.libraries = with pkgs; [
    stdenv.cc.cc
    zlib
    fuse3
    icu
    nss
    openssl
    curl
    expat
    linuxPackages.nvidia_x11 # This provides the 'libnvidia-ml.so' stub
    libx11
    # Add any other specific libs if other apps complain later
  ];

  # 4. Environment variables for CUDA to find the Windows Driver
  environment.variables = {
    LD_LIBRARY_PATH = "/usr/lib/wsl/lib";
  };

  # 5. Enable Flakes for future use
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05"; # Keep this as the version you installed
}
