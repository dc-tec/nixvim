_: {
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    disabledFiletypes = {
      statusline = ["dashboard" "alpha"];
    };
    theme = "catppuccin";
    sections = {
      lualine_a = [
        {
          name = "mode";
          fmt = "string.lower";
          color = {
            fg = "none";
            bg = "none";
          };
        }
      ];
      lualine_b = [
        {
          name = "branch";
          icon = "";
          color = {
            fg = "none";
            bg = "none";
          };
        }
        "diff"
      ];
      lualine_c = [
        {
          name = "diagnostic";
          extraConfig = {
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
          };
          color = {
            fg = "none";
            bg = "none";
          };
        }
      ];
      lualine_x = [
        {
          name = "filetype";
          extraConfig = {
            icon_only = true;
          };
        }
      ];
      lualine_y = [
        {
          name = "filename";
          extraConfig = {
            symbols = {
              modified = "";
              readonly = "";
              unnamed = "";
            };
          };
          color = {
            fg = "none";
            bg = "none";
          };
          separator.left = "";
        }
      ];
      lualine_z = [
        {
          name = "location";
          color = {
            fg = "none";
            bg = "none";
          };
        }
      ];
    };
  };
}
