{ pkgs, ... }: {

  plugins.treesitter = {
    enable = true;
    indent = true;
    folding = false;
    nixvimInjections = true;
    grammarPackages = pkgs.vimPlugins.nvim-treesitter.allGrammars;
  };

}
