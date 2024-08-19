_: {
  plugins = {
    markdown-preview = {
      enable = true;
      settings = {
        browser = "firefox";
        echo_preview_url = true;
        port = "6969";
        preview_options = {
          disable_filename = true;
          disable_sync_scroll = true;
          sync_scroll_type = "middle";
        };
        theme = "dark";
      };
    };
  };

  keymaps = [
    {
      mode = "n";
      key = "<leader>mp";
      action = "<cmd>MarkdownPreview<cr>";
      options = {
        desc = "Toggle Markdown Preview";
      };
    }
  ];
}
