{ config, ... }: 

{

  imports = [
    ./plugins/options.nix
    ./plugins/cmp.nix
    ./plugins/gitsigns.nix
    ./plugins/treesitter-telescope.nix # Has Harpoon as well
    ./plugins/ui.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";
 
  };
}
