{ pkgs, ... }: {
  
  plugins.neo-tree = {
    enable = true;
    sources =  [ "filesystem" "buffers" "git_status" "document_symbols" ];
    addBlankLineAtTop = true;
    
    filesystem = {
      bindToCwd = false;
    };
    
    defaultComponentConfigs = {
      indent = {
        expanderCollapsed = "";
        expanderExpanded = "";
        expanderHighlight = "NeoTreeExpander";
      };
    };
  };

}
