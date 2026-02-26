{ _ , ... }: 

{

  imports = [
    ./plugins/options.nix
    ./plugins/cmp.nix
    ./plugins/gitsigns.nix
    ./plugins/treesitter-telescope.nix # Has Harpoon as well
    ./plugins/linting-lsp.nix
    ./plugins/ui.nix
    ./plugins/qol.nix
  ];
  programs.nixvim = {
    enable = true;
    defaultEditor = true;
    globals.mapleader = " ";
 
  };
}
