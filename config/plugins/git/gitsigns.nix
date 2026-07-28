{
  plugins.gitsigns = {
    enable = true;
    settings = {
      preview_config = {
        border = "rounded";
      };
      signs = {
        add = {
          text = " ";
        };
        change = {
          text = " ";
        };
        delete = {
          text = " ";
        };
        untracked = {
          text = "";
        };
        topdelete = {
          text = "󱂥 ";
        };
        changedelete = {
          text = "󱂧 ";
        };
      };
      word_diff = false;
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "]h";
      action = "<cmd>Gitsigns nav_hunk next<cr>";
      options = {
        desc = "Next Git hunk";
      };
    }
    {
      mode = "n";
      key = "[h";
      action = "<cmd>Gitsigns nav_hunk prev<cr>";
      options = {
        desc = "Previous Git hunk";
      };
    }
    {
      mode = "n";
      key = "<leader>ghp";
      action = "<cmd>Gitsigns preview_hunk_inline<cr>";
      options = {
        desc = "Preview Git hunk inline";
      };
    }
    {
      mode = "n";
      key = "<leader>ghb";
      action = "<cmd>Gitsigns blame_line<cr>";
      options = {
        desc = "Blame Git line";
      };
    }
    {
      mode = "n";
      key = "<leader>gW";
      action = "<cmd>Gitsigns toggle_word_diff<cr>";
      options = {
        desc = "Toggle Git word diff";
      };
    }
  ];
}
