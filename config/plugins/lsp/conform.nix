{
  lib,
  pkgs,
  ...
}: {
  config = {
    extraConfigLuaPre =
      # lua
      ''
        local slow_format_filetypes = {}

        vim.api.nvim_create_user_command("FormatDisable", function(args)
           if args.bang then
            -- FormatDisable! will disable formatting just for this buffer
            vim.b.disable_autoformat = true
          else
            vim.g.disable_autoformat = true
          end
        end, {
          desc = "Disable autoformat-on-save",
          bang = true,
        })
        vim.api.nvim_create_user_command("FormatEnable", function()
          vim.b.disable_autoformat = false
          vim.g.disable_autoformat = false
        end, {
          desc = "Re-enable autoformat-on-save",
        })
        vim.api.nvim_create_user_command("FormatToggle", function(args)
          if args.bang then
            -- Toggle formatting for current buffer
            vim.b.disable_autoformat = not vim.b.disable_autoformat
          else
            -- Toggle formatting globally
            vim.g.disable_autoformat = not vim.g.disable_autoformat
          end
        end, {
          desc = "Toggle autoformat-on-save",
          bang = true,
        })
      '';
    plugins.conform-nvim = {
      enable = true;
      settings = {
        format_on_save = ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            local function on_format(err)
              if err and err:match("timeout$") then
                slow_format_filetypes[vim.bo[bufnr].filetype] = true
              end
            end

            return { timeout_ms = 200, lsp_fallback = true }, on_format
           end
        '';

        format_after_save = ''
          function(bufnr)
            if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
              return
            end

            if not slow_format_filetypes[vim.bo[bufnr].filetype] then
              return
            end

            return { lsp_fallback = true }
          end
        '';
        notify_on_error = true;
        formatters_by_ft = {
          html = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          css = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          javascript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          typescript = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          python = [
            "black"
            "isort"
          ];
          lua = ["stylua"];
          nix = ["alejandra"];
          markdown = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          yaml = [
            [
              "prettierd"
              "prettier"
            ]
          ];
          terraform = ["terraform_fmt"];
          bicep = ["bicep"];
          bash = [
            "shellcheck"
            "shellharden"
            "shfmt"
          ];
          json = ["jq"];
          "_" = ["trim_whitespace"];
        };

        formatters = {
          black = {
            command = "${lib.getExe pkgs.black}";
          };
          isort = {
            command = "${lib.getExe pkgs.isort}";
          };
          alejandra = {
            command = "${lib.getExe pkgs.alejandra}";
          };
          jq = {
            command = "${lib.getExe pkgs.jq}";
          };
          prettierd = {
            command = "${lib.getExe pkgs.prettierd}";
          };
          stylua = {
            command = "${lib.getExe pkgs.stylua}";
          };
          shellcheck = {
            command = "${lib.getExe pkgs.shellcheck}";
          };
          shfmt = {
            command = "${lib.getExe pkgs.shfmt}";
          };
          shellharden = {
            command = "${lib.getExe pkgs.shellharden}";
          };
          bicep = {
            command = "${lib.getExe pkgs.bicep}";
          };
          #yamlfmt = {
          #  command = "${lib.getExe pkgs.yamlfmt}";
          #};
        };
      };
    };
  };
}
