{
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    lsp.servers = {
      yamlls = {
        enable = true;
        settings = {
          validate = true;
          completion = true;
          hover = true;
          format.enable = false;
        };
      };

      helm_ls = {
        enable = true;
        extraOptions.settings."helm-ls" = {
          yamlls = {
            path = lib.getExe pkgs.yaml-language-server;
            config = {
              schemas.kubernetes = "templates/**";
              completion = true;
              hover = true;
            };
          };
        };
      };
    };

    conform-nvim.settings.formatters_by_ft = {
      yaml = {
        __unkeyed-1 = "prettierd";
        __unkeyed-2 = "prettier";
        stop_after_first = true;
      };
      "yaml.helm-values" = {
        __unkeyed-1 = "prettierd";
        __unkeyed-2 = "prettier";
        stop_after_first = true;
      };
    };
  };

  extraPlugins = with pkgs.vimPlugins; [
    ansible-vim
    helm-ls-nvim
  ];

  # helm-ls uses Helm for linting. A dev-shell version takes precedence.
  extraPackagesAfter = [ pkgs.kubernetes-helm ];

  extraConfigLua = ''
    require("helm-ls").setup({
      conceal_templates = { enabled = false },
    })
  '';
}
