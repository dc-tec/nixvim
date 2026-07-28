{ lib, ... }:
let
  projectTasksLua = # lua
    ''
      local overseer = require("overseer")

      local function find_root(marker, start, kind)
        local opts = {
          upward = true,
          path = start,
        }
        if kind then
          opts.type = kind
        end

        local match = vim.fs.find(marker, opts)[1]
        return match and vim.fs.dirname(match) or nil
      end

      local function validation_task(name, description, command, cwd)
        return {
          name = name,
          desc = description,
          tags = { overseer.TAG.TEST },
          builder = function()
            return {
              cmd = command,
              cwd = cwd,
              components = {
                {
                  "on_output_quickfix",
                  items_only = true,
                  open = false,
                  set_diagnostics = true,
                },
                "default",
              },
            }
          end,
        }
      end

      overseer.register_template({
        name = "project checks",
        generator = function(search)
          local tasks = {}

          local flake_root = find_root("flake.nix", search.dir, "file")
          if flake_root and vim.fn.executable("nix") == 1 then
            table.insert(tasks, validation_task(
              "project: nix flake check",
              "Run flake checks, including untracked files, without changing flake.lock",
              { "nix", "flake", "check", "path:.", "--no-write-lock-file" },
              flake_root
            ))
          end

          local go_root = find_root("go.mod", search.dir, "file")
          if go_root and vim.fn.executable("go") == 1 then
            table.insert(tasks, validation_task(
              "project: go test ./...",
              "Run all Go tests in the nearest module",
              { "go", "test", "./..." },
              go_root
            ))
          end

          local git_root = find_root(".git", search.dir)
          if git_root and vim.fn.executable("git") == 1 then
            table.insert(tasks, validation_task(
              "project: git diff --check",
              "Check the working tree for whitespace errors",
              { "git", "diff", "--check" },
              git_root
            ))
          end

          if vim.tbl_isempty(tasks) then
            return "No supported project checks found"
          end
          return tasks
        end,
      })

      vim.api.nvim_create_user_command("OverseerRestartLast", function()
        local task_list = require("overseer.task_list")
        local tasks = overseer.list_tasks({
          status = {
            overseer.STATUS.SUCCESS,
            overseer.STATUS.FAILURE,
            overseer.STATUS.CANCELED,
          },
          sort = task_list.sort_finished_recently,
        })

        if vim.tbl_isempty(tasks) then
          vim.notify("No completed tasks found", vim.log.levels.WARN)
          return
        end
        overseer.run_action(tasks[1], "restart")
      end, { desc = "Restart the most recently completed task" })
    '';
in
{
  plugins.overseer = {
    enable = true;
    settings = {
      dap = false;
      templates = [ "builtin" ];
      task_list = {
        default_detail = 1;
        direction = "bottom";
        min_height = 10;
        max_height = 20;
      };
    };
  };

  extraConfigLua = lib.mkAfter projectTasksLua;

  keymaps = [
    {
      mode = "n";
      key = "<leader>or";
      action = "<cmd>OverseerRun<cr>";
      options.desc = "Run project task";
    }
    {
      mode = "n";
      key = "<leader>ot";
      action = "<cmd>OverseerToggle<cr>";
      options.desc = "Toggle task list";
    }
    {
      mode = "n";
      key = "<leader>oa";
      action = "<cmd>OverseerTaskAction<cr>";
      options.desc = "Task action";
    }
    {
      mode = "n";
      key = "<leader>ol";
      action = "<cmd>OverseerRestartLast<cr>";
      options.desc = "Restart last task";
    }
  ];
}
