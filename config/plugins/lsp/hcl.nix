{
  pkgs,
  ...
}:
{
  plugins = {
    lsp.servers.tofu_ls = {
      enable = true;
      packageFallback = true;
    };

    conform-nvim.settings = {
      formatters_by_ft = {
        terraform = [ "tofu_fmt" ];
        opentofu = [ "tofu_fmt" ];
        "opentofu-vars" = [ "tofu_fmt" ];
      };
      formatters.tofu_fmt.command = "tofu";
    };
  };

  # tofu-ls and tofu_fmt use the project-managed binary when available.
  extraPackagesAfter = [ pkgs.opentofu ];

  extraConfigLuaPre = ''
    vim.treesitter.language.register("terraform", "opentofu")
    vim.treesitter.language.register("terraform", "opentofu-vars")
  '';
}
