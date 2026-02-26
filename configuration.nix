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

  programs.zsh.enable = true;


  # zramSwap.enable = true;
  # zramSwap.memoryPercent = 50;
  # zramSwap.algorithm = "zstd";
  fonts.packages = with pkgs; [
    nerd-fonts.fira-code
    nerd-fonts.jetbrains-mono
  ];



  # 5. Enable Flakes for future use
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  system.stateVersion = "25.05"; # Keep this as the version you installed
}
