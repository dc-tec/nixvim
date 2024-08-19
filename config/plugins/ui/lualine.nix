_: {
  plugins.lualine = {
    enable = true;
    globalstatus = true;
    extensions = [
      "fzf"
      "neo-tree"
    ];
    disabledFiletypes = {
      statusline = ["startup" "alpha"];
    };
    theme = "catppuccin";
    sections = {
      lualine_a = [
        {
          name = "mode";
          icon = " ";
        }
      ];
      lualine_b = [
        {
          name = "branch";
          icon = "";
        }
        {
          name = "diff";
          extraConfig = {
            symbols = {
              added = " ";
              modified = " ";
              removed = " ";
            };
          };
        }
      ];
      lualine_c = [
        {
          name = "diagnostics";
          extraConfig = {
            sources = ["nvim_lsp"];
            symbols = {
              error = " ";
              warn = " ";
              info = " ";
              hint = "󰝶 ";
            };
          };
        }
        {
          name = "navic";
        }
      ];
      lualine_x = [
        {
          name = "filetype";
          extraConfig = {
            icon_only = true;
            separator = "";
            padding = {
              left = 1;
              right = 0;
            };
          };
        }
        {
          name = "filename";
          extraConfig = {
            path = 1;
          };
        }
        {
          name.__raw = ''
            function()
              local icon = " "
              local status = require("copilot.api").status.data
              return icon .. (status.message or " ")
            end,

            cond = function()
             local ok, clients = pcall(vim.lsp.get_clients, { name = "copilot", bufnr = 0 })
             return ok and #clients > 0
            end,
          '';
        }
      ];
      lualine_y = [
        {
          name = "progress";
        }
      ];
      lualine_z = [
        {
          name = "location";
        }
      ];
    };
  };
}
