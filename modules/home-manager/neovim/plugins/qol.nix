{ _ }:

{
  programs.nixvim = {
    plugins = {
      # Quality of Life
      nvim-autopairs.enable = true;
      indent-blankline.enable = true;
      tmux-navigator.enable = true;
      mini = {
        enable = true;
        modules.icons = {};
        mockDevIcons = true;
      };
    };
  };
}
