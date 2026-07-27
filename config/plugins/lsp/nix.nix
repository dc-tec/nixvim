{
  lib,
  pkgs,
  ...
}:
{
  plugins = {
    lsp.servers.nixd = {
      enable = true;
      packageFallback = true;
      settings.formatting.command = [ (lib.getExe pkgs.nixfmt) ];
    };

    conform-nvim.settings = {
      formatters_by_ft.nix = [ "nixfmt" ];
      formatters.nixfmt.command = lib.getExe pkgs.nixfmt;
    };
  };
}
