{ lib, pkgs, ... }:
{
  plugins = {
    lsp.servers.gopls = {
      enable = true;
      settings.gopls = {
        gofumpt = true;
        usePlaceholders = true;
        analyses = {
          nilness = true;
          unusedparams = true;
          unusedwrite = true;
          useany = true;
        };
        hints = {
          assignVariableTypes = false;
          compositeLiteralFields = true;
          compositeLiteralTypes = true;
          constantValues = true;
          functionTypeParameters = true;
          parameterNames = true;
          rangeVariableTypes = true;
        };
      };
    };

    conform-nvim.settings = {
      formatters_by_ft.go = [
        "goimports"
        "gofumpt"
      ];
      formatters = {
        goimports.command = lib.getExe' pkgs.gotools "goimports";
        gofumpt.command = lib.getExe pkgs.gofumpt;
      };
    };

    dap = {
      enable = true;
      signs = {
        dapBreakpoint.text = "";
        dapBreakpointCondition.text = "";
        dapBreakpointRejected.text = "";
        dapLogPoint.text = "";
        dapStopped.text = "";
      };
    };
    dap-go = {
      enable = true;
      settings.delve.path = lib.getExe' pkgs.delve "dlv";
    };
    dap-ui = {
      enable = true;
      settings.floating.border = "rounded";
    };
    dap-virtual-text = {
      enable = true;
      settings = {
        commented = true;
        virt_text_pos = "eol";
      };
    };

    neotest = {
      enable = true;
      adapters.golang = {
        enable = true;
        settings = {
          dap_go_enabled = true;
          testify_enabled = true;
          warn_test_name_dupes = true;
          warn_test_not_executed = true;
          args = [ "-count=1" ];
        };
      };
      settings = {
        floating.border = "rounded";
        output.open_on_run = false;
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>rn";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run() end";
      options.desc = "Run nearest test";
    }
    {
      mode = "n";
      key = "<leader>rf";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run(vim.fn.expand('%')) end";
      options.desc = "Run test file";
    }
    {
      mode = "n";
      key = "<leader>rl";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run_last() end";
      options.desc = "Run last test";
    }
    {
      mode = "n";
      key = "<leader>rd";
      action = lib.nixvim.mkRaw "function() require('neotest').run.run({ strategy = 'dap' }) end";
      options.desc = "Debug nearest test";
    }
    {
      mode = "n";
      key = "<leader>rs";
      action = lib.nixvim.mkRaw "function() require('neotest').summary.toggle() end";
      options.desc = "Toggle test summary";
    }
    {
      mode = "n";
      key = "<leader>ro";
      action = lib.nixvim.mkRaw "function() require('neotest').output.open({ enter = true }) end";
      options.desc = "Show test output";
    }
    {
      mode = "n";
      key = "<F5>";
      action = lib.nixvim.mkRaw "function() require('dap').continue() end";
      options.desc = "Debug continue";
    }
    {
      mode = "n";
      key = "<F10>";
      action = lib.nixvim.mkRaw "function() require('dap').step_over() end";
      options.desc = "Debug step over";
    }
    {
      mode = "n";
      key = "<F11>";
      action = lib.nixvim.mkRaw "function() require('dap').step_into() end";
      options.desc = "Debug step into";
    }
    {
      mode = "n";
      key = "<F12>";
      action = lib.nixvim.mkRaw "function() require('dap').step_out() end";
      options.desc = "Debug step out";
    }
    {
      mode = "n";
      key = "<leader>db";
      action = lib.nixvim.mkRaw "function() require('dap').toggle_breakpoint() end";
      options.desc = "Toggle breakpoint";
    }
    {
      mode = "n";
      key = "<leader>dB";
      action = lib.nixvim.mkRaw "function() require('dap').set_breakpoint(vim.fn.input('Breakpoint condition: ')) end";
      options.desc = "Conditional breakpoint";
    }
    {
      mode = "n";
      key = "<leader>du";
      action = lib.nixvim.mkRaw "function() require('dapui').toggle() end";
      options.desc = "Toggle debug UI";
    }
    {
      mode = "n";
      key = "<leader>dt";
      action = lib.nixvim.mkRaw "function() require('dap').terminate() end";
      options.desc = "Terminate debugger";
    }
  ];

  extraConfigLua = ''
    local dap = require("dap")
    local dapui = require("dapui")

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end
  '';
}
