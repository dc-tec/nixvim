{ lib, ... }:
{
  extraFiles."lua/workspace_dashboard.lua".source = ./workspace_dashboard.lua;

  plugins.snacks = {
    enable = true;
    settings.dashboard = {
      enabled = true;
      width = 94;
      preset.header = ''
        ██████╗░███████╗░█████╗░░█████╗░██████╗░████████╗░░░████████╗███████╗░█████╗░██╗░░██╗
        ██╔══██╗██╔════╝██╔══██╗██╔══██╗██╔══██╗╚══██╔══╝░░░╚══██╔══╝██╔════╝██╔══██╗██║░░██║
        ██║░░██║█████╗░░██║░░╚═╝██║░░██║██████╔╝░░░██║░░░░░░░░░██║░░░█████╗░░██║░░╚═╝███████║
        ██║░░██║██╔══╝░░██║░░██╗██║░░██║██╔══██╗░░░██║░░░░░░░░░██║░░░██╔══╝░░██║░░██╗██╔══██║
        ██████╔╝███████╗╚█████╔╝╚█████╔╝██║░░██║░░░██║░░░██╗░░░██║░░░███████╗╚█████╔╝██║░░██║
        ╚═════╝░╚══════╝░╚════╝░░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░╚═╝░░░╚══════╝░╚════╝░╚═╝░░╚═╝
      '';
      sections = lib.nixvim.mkRaw ''
        (function()
          local row = require("workspace_dashboard").row

          local function heading(title)
            return {
              align = "center",
              padding = 1,
              text = { { title, hl = "title" } },
            }
          end

          return {
            { section = "header" },
            function()
              return require("workspace_dashboard").summary()
            end,

            heading("Review & Run"),
            row("󰕚", "d", "Review working tree", ":CodeDiff"),
            row("󰜘", "D", "Review branch", ":CodeReviewBranch"),
            row("󰄉", "h", "Review branch history", ":CodeReviewHistory"),
            row("󰑮", "t", "Run project task", ":OverseerRun"),

            heading("Navigate"),
            row("", "f", "Find file", ":Telescope find_files"),
            row("", "/", "Find text", ":Telescope live_grep"),
            row("", "e", "File explorer", ":Neotree toggle"),
            row("󰧑", "b", "SecondBrain", function()
              require("telescope.builtin").find_files({
                cwd = vim.fn.expand("~/projects/personal/SecondBrain"),
              })
            end),

            heading("Continue"),
            function()
              return require("workspace_dashboard").recent_files()
            end,

            (function()
              local quit = row("", "q", "Quit", ":qa")
              quit.padding = { 0, 1 }
              return quit
            end)(),
          }
        end)()
      '';
    };
  };

  extraConfigLua = lib.mkAfter ''
    local dashboard_group = vim.api.nvim_create_augroup("dashboard_chrome", { clear = true })
    local previous_laststatus

    local function hide_dashboard_statusline()
      if vim.bo.filetype ~= "snacks_dashboard" then
        return
      end

      if previous_laststatus == nil then
        previous_laststatus = vim.o.laststatus
      end
      vim.o.laststatus = 0
      vim.wo.statusline = ""
      vim.b.miniindentscope_disable = true
    end

    local function restore_statusline()
      if previous_laststatus == nil then
        return
      end

      vim.o.laststatus = previous_laststatus
      previous_laststatus = nil
    end

    vim.api.nvim_create_autocmd({ "FileType", "BufEnter", "WinEnter" }, {
      group = dashboard_group,
      pattern = "*",
      callback = hide_dashboard_statusline,
    })

    -- Snacks temporarily suppresses normal buffer events while creating the
    -- dashboard, so its lifecycle event owns the initial chrome update.
    vim.api.nvim_create_autocmd("User", {
      group = dashboard_group,
      pattern = { "SnacksDashboardOpened", "SnacksDashboardUpdatePost" },
      callback = hide_dashboard_statusline,
    })

    vim.api.nvim_create_autocmd("BufLeave", {
      group = dashboard_group,
      pattern = "*",
      callback = function()
        if vim.bo.filetype ~= "snacks_dashboard" then
          return
        end

        restore_statusline()
      end,
    })

    vim.api.nvim_create_autocmd("User", {
      group = dashboard_group,
      pattern = "SnacksDashboardClosed",
      callback = restore_statusline,
    })
  '';
}
