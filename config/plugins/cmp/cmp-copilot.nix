{
  plugins.copilot-cmp = {
    enable = true;
  };
  plugins.copilot-lua = {
    settings = {
      copilot = {
        suggestion = {
          enabled = false;
        };
        panel = {
          enabled = false;
        };
      };
    };
  };

  extraConfigLua = ''
    require("copilot").setup({
      suggestion = { enabled = false },
      panel = { enabled = false },
    })
  '';
}
