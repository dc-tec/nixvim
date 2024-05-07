{
  autoCmd = [
    {
      group = "highlight_yank";
      callback = ''
        function()
          vim.highlight.on_yank()
      '';
    }
  ];
}
