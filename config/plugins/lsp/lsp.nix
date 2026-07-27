{
  plugins = {
    lsp-lines = {
      enable = true;
    };
    lsp = {
      enable = true;
      inlayHints = true;
      servers = {
        html = {
          enable = true;
        };
        lua_ls = {
          enable = true;
        };
        ts_ls = {
          enable = true;
        };
        marksman = {
          enable = true;
        };
        pyright = {
          enable = true;
        };
        jsonls = {
          enable = true;
        };
      };

      keymaps = {
        silent = true;
        lspBuf = {
          gd = {
            action = "definition";
            desc = "Goto Definition";
          };
          gr = {
            action = "references";
            desc = "Goto References";
          };
          gD = {
            action = "declaration";
            desc = "Goto Declaration";
          };
          gI = {
            action = "implementation";
            desc = "Goto Implementation";
          };
          gT = {
            action = "type_definition";
            desc = "Type Definition";
          };
          K = {
            action = "hover";
            desc = "Hover";
          };
          "<leader>cw" = {
            action = "workspace_symbol";
            desc = "Workspace Symbol";
          };
          "<leader>cr" = {
            action = "rename";
            desc = "Rename";
          };
        };
      };
    };
  };
  extraConfigLua = ''
    local _border = "rounded"

    -- Language servers can emit large volumes of routine stderr output.
    -- Logging can be re-enabled interactively when troubleshooting.
    vim.lsp.log.set_level(vim.log.levels.OFF)

    vim.lsp.handlers["textDocument/hover"] = function(err, result, ctx, config)
      config = config or {}
      config.border = _border
      return vim.lsp.handlers.hover(err, result, ctx, config)
    end

    vim.lsp.handlers["textDocument/signatureHelp"] = function(err, result, ctx, config)
      config = config or {}
      config.border = _border
      return vim.lsp.handlers.signature_help(err, result, ctx, config)
    end

    vim.diagnostic.config{
      float={border=_border}
    };

    require('lspconfig.ui.windows').default_options = {
      border = _border
    }
  '';
}
