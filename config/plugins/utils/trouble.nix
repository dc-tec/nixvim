_: {
  plugins.trouble = {
    enable = true;
    settings = {
      auto_close = true;
      auto_preview = true;
      auto_refresh = true;
      focus = true;
      follow = true;
      multiline = true;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>cs";
      action = "<cmd>Trouble symbols toggle focus=false<cr>";
      options.desc = "Document symbols";
    }
    {
      mode = "n";
      key = "<leader>cl";
      action = "<cmd>Trouble lsp toggle focus=false win.position=right<cr>";
      options.desc = "LSP locations";
    }
    {
      mode = "n";
      key = "<leader>xx";
      action = "<cmd>Trouble diagnostics toggle<cr>";
      options.desc = "Workspace diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xX";
      action = "<cmd>Trouble diagnostics toggle filter.buf=0<cr>";
      options.desc = "Buffer diagnostics";
    }
    {
      mode = "n";
      key = "<leader>xq";
      action = "<cmd>Trouble qflist toggle<cr>";
      options.desc = "Quickfix list";
    }
    {
      mode = "n";
      key = "<leader>xl";
      action = "<cmd>Trouble loclist toggle<cr>";
      options.desc = "Location list";
    }
    {
      mode = "n";
      key = "<leader>xt";
      action = "<cmd>TodoTrouble toggle<cr>";
      options.desc = "Todo comments";
    }
  ];
}
