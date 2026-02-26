{config, ...}:

{
  programs.nixvim = {
    plugins = {
      cmp = {
        enable = true;
        autoEnableSources = true;
        settings = {
          sources = [
            { name = "nvim_lsp"; }
            { name = "path"; }
            { name = "buffer"; }
            { name = "cmdline"; }
          ];
          mapping = {
            "<C-Space>" = config.lib.nixvim.mkRaw "cmp.mapping.complete()";
            "<C-j>" = config.lib.nixvim.mkRaw "cmp.mapping.select_next_item()";
            "<C-k>" = config.lib.nixvim.mkRaw "cmp.mapping.select_prev_item()";
          };
          window = {
            completion.border = "rounded";
            documentation.border = "rounded";
          };
        };
        cmdline = {
          "/" = {
            mapping = config.lib.nixvim.mkRaw "cmp.mapping.preset.cmdline()";
            sources = [ { name = "buffer"; } ];
          };
          ":" = {
            mapping = config.lib.nixvim.mkRaw "cmp.mapping.preset.cmdline()";
            sources = [
              { name = "path"; }
              { name = "cmdline"; }
            ];
          };
        };
      };
      # Completion Helpers
      cmp-nvim-lsp.enable = true;
      cmp-path.enable = true;
      cmp-buffer.enable = true;
      cmp-cmdline.enable = true;
      luasnip.enable = true;
    };
  };
}
