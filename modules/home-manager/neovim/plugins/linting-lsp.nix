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
            markdownlint = {
              enable = true;
              settings= {
                extra_args = [ "--disable" "MD013"];
              };
            };
          };
          formatting = {
            alejandra.enable = true;
            prettierd = {
              enable = true;
              disableTsServerFormatter = true;
            };
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
          ruff.enable=true;
          bashls.enable=true;
        };
      };
    };
  };
}

