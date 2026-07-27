{ lib, ... }:
{
  dependencies.rust-analyzer.packageFallback = true;

  plugins = {
    rustaceanvim = {
      enable = true;
      settings = {
        server.load_vscode_settings = true;
        tools.enable_clippy = true;
      };
    };

    # Rustaceanvim's adapter asks rust-analyzer for the actual test targets and
    # reuses its debugger detection. The shared <leader>r mappings then work for
    # both Go and Rust.
    neotest.settings.adapters = [ "require('rustaceanvim.neotest')" ];
  };

  autoCmd = [
    {
      event = "FileType";
      pattern = "rust";
      desc = "Rustaceanvim keymaps";
      callback = lib.nixvim.mkRaw ''
        function(args)
          local function rust_lsp(command)
            return function()
              vim.cmd.RustLsp(command)
            end
          end

          local opts = { buffer = args.buf, silent = true }
          vim.keymap.set("n", "<leader>Ra", rust_lsp("codeAction"), vim.tbl_extend("force", opts, { desc = "Rust code action" }))
          vim.keymap.set("n", "<leader>Rr", rust_lsp("runnables"), vim.tbl_extend("force", opts, { desc = "Rust runnables" }))
          vim.keymap.set("n", "<leader>Rt", rust_lsp("testables"), vim.tbl_extend("force", opts, { desc = "Rust testables" }))
          vim.keymap.set("n", "<leader>Rd", rust_lsp("debuggables"), vim.tbl_extend("force", opts, { desc = "Rust debuggables" }))
        end
      '';
    }
  ];
}
