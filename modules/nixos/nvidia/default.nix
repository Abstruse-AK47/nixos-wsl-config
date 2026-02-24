{ pkgs, config, ... }:

{
  # 1. Force NixOS to use the WSL driver bridge
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

  nixpkgs.config.allowUnfree = true;
  programs.nix-ld.enable = true;

  # 2. Block the Linux kernel from trying to load its own NVIDIA modules
  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_uvm" "nvidia_drm" "nvidia_modeset" ];

  # 3. Ensure the OpenGL/Graphics bridge is active
  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs; [
      # These help the 'handshake' between WSL and Windows
      # mesa.drivers
    ];
  };
  
  hardware.nvidia = {
   modesetting.enable=true;
   package = config.boot.kernelPackages.nvidiaPackages.stable;
  };


  # # 4. Your existing environment variables (keep these!)
  # environment.variables = {
  #   LD_LIBRARY_PATH = [ "/usr/lib/wsl/lib" ];
  # };
}
