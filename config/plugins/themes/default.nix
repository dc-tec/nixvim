{
  colorschemes = {
    catppuccin = {
      enable = true;
      settings = {
        background = {
          light = "macchiato";
          dark = "mocha";
        };
        flavour = "macchiato"; # "latte", "mocha", "frappe", "macchiato" or raw lua code
        no_bold = false;
        no_italic = false;
        no_underline = false;
        transparent_background = true;
        integrations = {
          cmp = true;
          notify = true;
          gitsigns = true;
          dashboard = true;
          lualine = true;
          which_key = true;
          illuminate = {
            enabled = true;
          };
          treesitter = true;
          telescope.enabled = true;
          indent_blankline.enabled = true;
          mini.enabled = true;
          native_lsp = {
            enabled = true;
            inlay_hints = {
              background = true;
            };
            underlines = {
              errors = ["underline"];
              hints = ["underline"];
              information = ["underline"];
              warnings = ["underline"];
            };
          };
        };
      };
    };
  };
}
