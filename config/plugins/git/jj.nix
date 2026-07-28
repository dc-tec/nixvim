{
  plugins.jj = {
    enable = true;
    settings = {
      cmd.describe.editor = {
        type = "buffer";
      };
      diff.backend = "codediff";
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>jl";
      action = "<cmd>J log<cr>";
      options = {
        desc = "Jujutsu log";
      };
    }
    {
      mode = "n";
      key = "<leader>js";
      action = "<cmd>J status<cr>";
      options = {
        desc = "Jujutsu status";
      };
    }
    {
      mode = "n";
      key = "<leader>jd";
      action = "<cmd>J describe<cr>";
      options = {
        desc = "Jujutsu describe";
      };
    }
    {
      mode = "n";
      key = "<leader>jn";
      action = "<cmd>J new<cr>";
      options = {
        desc = "Jujutsu new change";
      };
    }
    {
      mode = "n";
      key = "<leader>ju";
      action = "<cmd>J undo<cr>";
      options = {
        desc = "Jujutsu undo";
      };
    }
    {
      mode = "n";
      key = "<leader>jr";
      action = "<cmd>J redo<cr>";
      options = {
        desc = "Jujutsu redo";
      };
    }
    {
      mode = "n";
      key = "<leader>jf";
      action = "<cmd>J fetch<cr>";
      options = {
        desc = "Jujutsu fetch";
      };
    }
  ];
}
