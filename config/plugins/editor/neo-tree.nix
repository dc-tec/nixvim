{
  plugins.neo-tree = {
    enable = true;
    sources = ["filesystem" "buffers" "git_status" "document_symbols"];
    addBlankLineAtTop = false;

    filesystem = {
      bindToCwd = false;
    };

    defaultComponentConfigs = {
      indent = {
        withExpanders = true;
        expanderCollapsed = "";
        expanderExpanded = " ";
        expanderHighlight = "NeoTreeExpander";
      };
    };
  };

  keymaps = [
    {
      mode = ["n"];
      key = "<leader>e";
      action = "<cmd>Neotree toggle<cr>";
      options = {desc = "Open/Close Neotree";};
    }
  ];
}
