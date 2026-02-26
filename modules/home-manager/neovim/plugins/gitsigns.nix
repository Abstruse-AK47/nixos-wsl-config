{ _ , ...}:

{
  programs.nixvim= {
    plugins = {

      gitsigns = {
        enable = true;
        settings = {
          # Minimalist signs: + for add, ~ for change, - for delete
          signs = {
            add = { text = "┃"; };
            change = { text = "┃"; };
            delete = { text = " "; };
            topdelete = { text = "▔"; };
            changedelete = { text = "~"; };
            untracked = { text = "┆"; };
          };
          # This ensures the signs don't look weird with your transparent background
          signcolumn = true;
          numhl = false; # Set to true if you want the line numbers to change color
          linehl = false;
          word_diff = false;
          watch_gitdir = {
            follow_files = true;
          };
        };
      };
    };
  };
}
