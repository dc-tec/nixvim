{ pkgs, ... }: {
  
  plugins.neo-tree = {
    enable = true;
    sources =  [ "filesystem" "buffers" "git_status" "document_symbols" ];
    addBlankLineAtTop = true;
    
    fileSystem = {
      window = {
        bindToCwd = false;
      };
    };
    
    window = {
      mappings = {
        
      };
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
