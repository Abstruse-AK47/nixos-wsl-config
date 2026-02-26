{ pkgs , ...}:

{
  programs.nixvim = {
    # 1. Tell NixVim to use Nightfly as the main colorscheme
    colorscheme = "nightfly";

    # 2. Add the actual plugin package
    extraPlugins = with pkgs.vimPlugins; [
      nightfly
    ];

    # 3. Optional: Refine the look (transparency & HUD)
    # extraConfigLua = ''
    #   -- Nightfly specific settings
    #   vim.g.nightflyTransparent = true
    #   vim.g.nightflyVirtualTextColor = true
    #   '';    
    plugins = {
      # UI & HUD
      noice = {
        enable = true;
        settings = {
          top_down = false; 
          lsp.override = {
            "vim.lsp.util.convert_input_to_markdown_lines" = true;
            "vim.lsp.util.stylize_markdown" = true;
            "cmp.entry.get_documentation" = true;
          };
          presets = {
            bottom_search = false;
            command_palette = true;
            long_message_to_split = true;
          };
          # Centered UI placement
          views = {
            cmdline_popup = {
              position = { row = "40%"; col = "50%"; };
              size = { width = 60; height = "auto"; };
            };
            popupmenu = {
              relative = "editor";
              position = { row = "53%"; col = "50%"; };
              size = { width = 60; height = 10; };
              border = { style = "rounded"; padding = [ 0 1 ]; };
              enabled = true;
              backend = "nui";
            };
          };
        };
      };

      # Notification base
      notify = {
        enable = true;
        settings = {
          background_colour = "#000000"; # Renamed and moved inside settings
          fps = 60;
          render = "minimal";
          stages = "fade";
          timeout = 2000;
        };
      };      

      # Transparent
      transparent = {
        enable = true;
        settings = {
          groups = [
            "Normal"
            "NormalNC"
            "Comment"
            "Constant"
            "Special"
            "Identifier"
            "Statement"
            "PreProc"
            "Type"
            "Underlined"
            "Todo"
            "String"
            "Function"
            "Conditional"
            "Repeat"
            "Operator"
            "Structure"
            "LineNr"
            "NonText"
            "SignColumn"
            "CursorLineNr"
            "EndOfBuffer"
            "CursorLine"
            # "NightflyVisual"
          ];
          extra_groups = [
            "NormalFloat"
            "NvimTreeNormal"
            "NvimTreeNormalNC"
            "NvimTreeNormalFloat"
            "NvimTreeEndOfBuffer"
          ];
        };
      };
    };
  };
}
