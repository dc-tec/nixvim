{
  lib,
  mdRender,
  mmdr,
  pkgs,
  ...
}:
let
  mdRenderPlugin = pkgs.vimUtils.buildVimPlugin {
    pname = "md-render.nvim";
    version = "3.4.0";
    src = mdRender;
  };

  mmdc = pkgs.writeShellApplication {
    name = "mmdc";
    text = ''
      input=""
      output=""
      theme=""
      background=""

      while (( $# > 0 )); do
        if (( $# < 2 )); then
          echo "mmdc: missing value for $1" >&2
          exit 2
        fi

        case "$1" in
          -i|--input)
            input="$2"
            ;;
          -o|--output)
            output="$2"
            ;;
          -t|--theme)
            theme="$2"
            ;;
          -b|--backgroundColor)
            background="$2"
            ;;
          -s|--scale)
            ;;
          *)
            echo "mmdc: unsupported argument: $1" >&2
            exit 2
            ;;
        esac

        shift 2
      done

      if [[ -z "$input" || -z "$output" ]]; then
        echo "mmdc: input and output are required" >&2
        exit 2
      fi

      args=(-i "$input" -o "$output" -e png)
      if [[ -n "$theme" ]]; then
        args+=(-t "$theme")
      fi

      if [[ -n "$background" ]]; then
        config="$(mktemp "''${TMPDIR:-/tmp}/md-render-mmdr.XXXXXX")"
        trap 'rm -f -- "$config"' EXIT
        printf '{"themeVariables":{"background":"%s"}}\n' "$background" > "$config"
        args+=(-c "$config")
      fi

      ${lib.getExe mmdr} "''${args[@]}"
    '';
  };
in
{
  extraPlugins = [ mdRenderPlugin ];
  extraPackages = [ mmdc ];

  keymaps = [
    {
      mode = "n";
      key = "<leader>mp";
      action = lib.nixvim.mkRaw ''
        function()
          local columns = vim.o.columns
          local width = math.min(160, math.floor(columns * 0.8), math.max(80, math.floor(columns * 0.6)))

          require("md-render").preview.show({ max_width = width - 2 })

          local win = vim.api.nvim_get_current_win()
          local config = vim.api.nvim_win_get_config(win)
          if config.relative ~= "" then
            vim.api.nvim_win_set_config(win, {
              relative = config.relative,
              width = width,
              row = config.row,
              col = math.floor((columns - width) / 2),
            })
          end
        end
      '';
      options = {
        desc = "Toggle Markdown preview";
      };
    }
    {
      mode = "n";
      key = "<leader>ms";
      action = "<cmd>vertical MdRender split<cr>";
      options = {
        desc = "Open synchronized Markdown split";
      };
    }
  ];
}
