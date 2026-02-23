{ pkgs, config, ... }:

{
  # 1. Force NixOS to use the WSL driver bridge

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
