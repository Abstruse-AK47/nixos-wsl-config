{ _ , ... }:

{
  programs.nixvim = {
    plugins = {
      # Linting & Formatting
      none-ls = {
        enable = true;
        sources = {
          diagnostics = {
            statix.enable = true;
            ruff.enable = true;
            shellcheck.enable = true;
          };
          formatting = {
            alejandra.enable = true;
            ruff.enable = true;
          };
        };
      };
      # LSP
      lsp = {
        enable = true;
        servers = {
          nil_ls.enable = true;
          lua_ls.enable = true;
          pyright.enable = true;
        };
      };
    };
  };
}
