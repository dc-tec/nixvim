{
  archlens,
  lib,
  pkgs,
  ...
}:
{
  extraPlugins = [ archlens ];
  extraPackagesAfter = [ pkgs.ast-grep ];

  extraConfigLua = lib.mkAfter ''
    require("archlens").setup({
      width = 64,
      max_items = 8,
      include_external = false,
      ast_grep = {
        command = "${lib.getExe pkgs.ast-grep}",
        timeout_ms = 15000,
        max_results = 80,
        min_name_length = 5,
      },
    })
  '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>cm";
      action = "<cmd>ArchLensHere<cr>";
      options = {
        desc = "Map local and project relationships";
        silent = true;
      };
    }
  ];
}
