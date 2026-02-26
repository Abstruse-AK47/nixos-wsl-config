{_}:

{
  programs.nixvim = {
    plugins = {  
      # Treesitter
      treesitter = {
        enable = true;
        nixGrammars = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Search & Navigation
      telescope = {
        enable = true;
        extensions = {
          fzf-native.enable = true;
          noice.enable = true;
        };
        settings.defaults.mappings.i = {
          "<C-j>" = "move_selection_next";
          "<C-k>" = "move_selection_previous";
        };
      };
      # Harpoon
      harpoon = {
        enable = true;
        enableTelescope = true;
      };
    };
  };
}
