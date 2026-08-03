{
  lib,
  pkgs,
  ...
}:
{
  plugins.lsp.servers.ocamllsp = {
    enable = true;
    # Prefer the server from the active opam switch or Dune tools environment.
    packageFallback = true;
  };

  # OCaml-LSP needs Dune to load project documents and delegates formatting to
  # ocamlformat. Keep both as fallbacks so project-local tools remain authoritative.
  extraPackagesAfter = [
    pkgs.dune_3
    pkgs.ocamlPackages.ocamlformat
  ];

  autoCmd = [
    {
      event = "FileType";
      pattern = [
        "ocaml"
        "ocamlinterface"
      ];
      desc = "OCaml implementation/interface keymap";
      callback = lib.nixvim.mkRaw ''
        function(args)
          vim.keymap.set("n", "<leader>oi", function()
            vim.cmd.LspOcamllspSwitchImplIntf()
          end, {
            buffer = args.buf,
            desc = "OCaml switch implementation/interface",
            silent = true,
          })
        end
      '';
    }
  ];
}
