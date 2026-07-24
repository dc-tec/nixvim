# NixVim Configuration

This repository contains my personal configuration NixVim, a Neovim configuration managed with Nix.

![Neovim](./.docs/images/neovim.png)

## How to use

You can use this flake as an input:

```nix
{
    inputs = {
        nixvim.url = "github:dc-tec/nixvim"
    };
}
```

You can then install the package either normally or through home-manager.

#### Normal:

```nix
environment.systemPackages = [
    inputs.nixvim.packages.x86_64-linux.default
];
```

#### Home-Manager

```nix
home-manager.users.<user>.home.packages = [
    inputs.nixvim.packages.x86_64-linux.default
];
```

## Plugins

### General Configuration

- `settings.nix`: Contains general settings for Neovim.
- `keymaps.nix`: Defines key mappings.
- `auto_cmds.nix`: Sets up automatic commands.
- `file_types.nix`: Configures file type specific settings.

### Themes

- `default.nix`: Sets the default theme.

### Completion

- `cmp.nix`: Configures the cmp completion framework.
- `lspkind.nix`: Adds icons to lsp completion items.
- `autopairs.nix`: Adds the autopairs plugin.
- `schemastore.nix`: Adds the schemastore plugin for JSON and YAML schemas.

### Snippets

- `luasnip.nix`: Configures the LuaSnip snippet engine.

### Editor Plugins and Configurations

- `neo-tree.nix`: Configures the NeoTree file explorer.
- `treesitter.nix`: Configures the TreeSitter syntax highlighter.
- `undotree.nix`: Configures the UndoTree undo history visualizer.
- `illuminate.nix`: Configures the Illuminate plugin for highlighting other uses of the current word under the cursor.
- `indent-blankline.nix`: Configures the Indent Blankline plugin for displaying indentation levels.
- `todo-comments.nix`: Configures the Todo Comments plugin for highlighting TODO comments.
- `navic.nix`: Configures the Navic plugin, shows the current code context.

### UI Plugins

- `bufferline.nix`: Configures the Bufferline plugin for enhanced buffer/tab display.
- `lualine.nix`: Configures the Lualine status line plugin.
- `startup.nix`: Configures the startup screen.

### LSP

- `lsp.nix`: Configures the Neovim LSP client.
- `conform.nix`: Configures the Conform plugin for automatic code formatting.
- `fidget.nix`: Configures the Fidget plugin for displaying LSP diagnostics in the status line.

### Git

- `lazygit.nix`: Configures the LazyGit plugin for Git integration.
- `gitsigns.nix`: Configures the GitSigns plugin for displaying Git diff information.

### Utils

- `telescope.nix`: Configures the Telescope plugin for fuzzy finding and picking.
- `whichkey.nix`: Configures the WhichKey plugin for displaying key mappings.
- `extra_plugins.nix`: Configures additional plugins.
- `mini.nix`: Configures the Mini plugin.
- `obsidian.nix`: Confiugres the Obsidian plugin, for note-taking purposes.
- `markdown-preview.nix`: Configures the Markdown Preview plugin.
- `toggleterm.nix`: Configures Terminal plugin.

Please refer to the individual `.nix` files for more detailed configuration information.

## References

This configuration has taken inspiration from the following contributors.

- [Elythh](https://github.com/elythh/nixvim)
- [MikaelFangel](https://github.com/MikaelFangel/nixvim-config)
