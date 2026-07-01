{ _ , ...}:

{
  programs.nixvim = {
    plugins = {  
      # Treesitter
      treesitter.legacy.enable=false;
      treesitter = {
        enable = true;
        # nixGrammars = true;
        nixvimInjected = true;
        settings = {
          highlight.enable = true;
          indent.enable = true;
        };
      };

      # Search & Navigation
      telescope = {
        enable = true;
        enabledExtensions = ["noice"];
        extensions = {
          fzf-native.enable = true;
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
