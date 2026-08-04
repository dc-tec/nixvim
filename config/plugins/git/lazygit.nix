_: {
  plugins.lazygit.enable = true;

  extraConfigLua = # lua
    ''
      require("telescope").load_extension("lazygit")

      local function normalize(path)
        if not path or path == "" then
          return nil
        end

        return vim.uv.fs_realpath(path) or vim.fs.normalize(path)
      end

      local function git_root(path)
        local result = vim.system(
          { "git", "-C", path, "rev-parse", "--show-toplevel" },
          { text = true }
        ):wait()

        if result.code ~= 0 then
          return nil
        end

        return normalize(vim.trim(result.stdout or ""))
      end

      local function read_handoff(path)
        local ok, lines = pcall(vim.fn.readfile, path)
        vim.fn.delete(path)

        if not ok or not lines[1] then
          return nil
        end

        return git_root(vim.trim(lines[1]))
      end

      local function open_worktree(path)
        vim.cmd.tabnew()
        vim.cmd.tcd(vim.fn.fnameescape(path))

        local snacks_ok, snacks = pcall(require, "snacks")
        if snacks_ok then
          snacks.dashboard()
        end

        vim.notify(
          ("Opened worktree %s"):format(vim.fs.basename(path)),
          vim.log.levels.INFO,
          { title = "LazyGit" }
        )
      end

      local handoff = vim.fn.tempname()
      local previous_handoff = vim.env.LAZYGIT_NEW_DIR_FILE
      local previous_callback = vim.g.lazygit_on_exit_callback

      vim.env.LAZYGIT_NEW_DIR_FILE = handoff
      vim.g.lazygit_on_exit_callback = function()
        local source_root = git_root(vim.uv.cwd())
        local target_root = read_handoff(handoff)

        if type(previous_callback) == "function" then
          local ok, err = pcall(previous_callback)
          if not ok then
            vim.notify(err, vim.log.levels.ERROR, { title = "LazyGit callback" })
          end
        end

        if target_root and target_root ~= source_root then
          open_worktree(target_root)
        end
      end

      local lazygit_worktree_group = vim.api.nvim_create_augroup("lazygit_worktree", { clear = true })

      vim.api.nvim_create_autocmd("TermClose", {
        group = lazygit_worktree_group,
        callback = function(args)
          if vim.bo[args.buf].filetype == "lazygit" and vim.v.event.status ~= 0 then
            vim.fn.delete(handoff)
          end
        end,
      })

      vim.api.nvim_create_autocmd("VimLeavePre", {
        group = lazygit_worktree_group,
        once = true,
        callback = function()
          vim.fn.delete(handoff)
          vim.env.LAZYGIT_NEW_DIR_FILE = previous_handoff
          vim.g.lazygit_on_exit_callback = previous_callback
        end,
      })
    '';

  keymaps = [
    {
      mode = "n";
      key = "<leader>gg";
      action = "<cmd>LazyGit<CR>";
      options = {
        desc = "LazyGit (worktree aware)";
      };
    }
  ];
}
