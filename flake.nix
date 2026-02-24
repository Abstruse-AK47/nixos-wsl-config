{
  description = "My Declarative WSL System";

  inputs = {
    # Use the unstable branch for the latest Neovim and CUDA versions
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Helps manage NixOS on WSL specifically
    nixos-wsl.url = "github:nix-community/NixOS-WSL/main";
    home-manager = {
	url = "github:nix-community/home-manager";
	inputs.nixpkgs.follows = "nixpkgs";
	};
  };
	
  outputs = { self, nixpkgs,home-manager, nixos-wsl, ... } @ inputs: {
    nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        nixos-wsl.nixosModules.default
        ./configuration.nix # Points to your local config
	home-manager.nixosModules.home-manager
	{
	   home-manager = {
	   	useGlobalPkgs = true;
		useUserPackages = true;
		extraSpecialArgs = { inherit inputs; };
		users.nixos = import ./home.nix;
		backupFileExtension = "backup";
	   };
	}
      ];
    };
  };
}
