{ pkgs, ... }:
{
  plugins.treesitter = {
    enable = true;
    settings = {
      indent.enable = true;
      highlight.enable = true;
    };
    folding.enable = false;
    nixvimInjections = true;
    grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
      bash
      bicep
      css
      diff
      dockerfile
      git_config
      git_rebase
      gitattributes
      gitcommit
      gitignore
      go
      gomod
      gosum
      gotmpl
      gowork
      hcl
      helm
      html
      javascript
      json
      lua
      make
      markdown
      markdown_inline
      nix
      ocaml
      ocaml_interface
      python
      regex
      rust
      sql
      terraform
      toml
      tsx
      typescript
      vim
      vimdoc
      yaml
    ];
  };

  plugins.treesitter-textobjects = {
    enable = false;
    settings = {
      select = {
        enable = true;
        lookahead = true;
        keymaps = {
          "aa" = "@parameter.outer";
          "ia" = "@parameter.inner";
          "af" = "@function.outer";
          "if" = "@function.inner";
          "ac" = "@class.outer";
          "ic" = "@class.inner";
          "ii" = "@conditional.inner";
          "ai" = "@conditional.outer";
          "il" = "@loop.inner";
          "al" = "@loop.outer";
          "at" = "@comment.outer";
        };
      };
      move = {
        enable = true;
        goto_next_start = {
          "]m" = "@function.outer";
          "]]" = "@class.outer";
        };
        goto_next_end = {
          "]M" = "@function.outer";
          "][" = "@class.outer";
        };
        goto_previous_start = {
          "[m" = "@function.outer";
          "[[" = "@class.outer";
        };
        goto_previous_end = {
          "[M" = "@function.outer";
          "[]" = "@class.outer";
        };
      };
      swap = {
        enable = true;
        swap_next = {
          "<leader>a" = "@parameters.inner";
        };
        swap_previous = {
          "<leader>A" = "@parameter.outer";
        };
      };
    };
  };
}
