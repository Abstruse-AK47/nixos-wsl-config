{ pkgs, ... }:

{

  imports = [
    ./modules/nixos/nvidia/default.nix
  ];
  # 1. WSL Specifics
  wsl = {
    enable = true;
    defaultUser = "nixos"; 
    useWindowsDriver = true;
    wslConf.interop = {
      enabled = true;
      appendWindowsPath = true;
    };
    interop.register = false;
  };



  systemd.services."status-check" = {
    script = "echo 'Systemd is running'";
    wantedBy = [ "multi-user.target"] ;
  };



  # 2. Set it as the default shell for your user
  users.users.nixos = {
    isNormalUser = true;
    shell = pkgs.zsh;
  };

  programs = {
    zsh = {
      enable = true;
    };
    nix-ld = {
      enable = true;
    };
    nix-ld.libraries = with pkgs; [
      stdenv.cc.cc.lib       # Fixes libstdc++.so.6 (NumPy)
      zlib                   # Fixes libz.so.1
      glib                   # Fixes libglib (OpenCV backend)
      libGL                  # Fixes libGL graphics context rendering
      ffmpeg_4               # Fixes libavcodec.so.58 video streams
      cudaPackages.cudatoolkit # Provides libcufft.so.12 system-wide
    ];
  };

  
  
  # zramSwap.enable = true;
  # zramSwap.memoryPercent = 50;
  # zramSwap.algorithm = "zstd";
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];

  nixpkgs.config.allowUnfree = true;


  nix.settings = {
  substituters = [ 
        "https://cache.nixos.org"
        "https://nix-community.cachix.org" 
      ];
      trusted-public-keys = [ 
        "cache.nixos.org-1:6NCHdD59X431o0gWypbMrAURkbJ16ZPMQFGspcDShjY="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs=" 
      ];
    experimental-features = [ "nix-command" "flakes" ];
    trusted-users = ["root" "nixos"];
  };

  system.stateVersion = "25.05"; # Keep this as the version you installed
}
